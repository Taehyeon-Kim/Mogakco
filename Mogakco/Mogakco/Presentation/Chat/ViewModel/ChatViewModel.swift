//
//  ChatViewModel.swift
//  Mogakco
//
//  Created by taekki on 2022/11/30.
//

import Foundation

import RxCocoa
import RxSwift

struct ChatViewModel: ViewModelType {
    
    private let disposeBag = DisposeBag()
    private let networkProvider: NetworkProvider
    private let chatRepository: ChatRepositoryImpl<Chat>
    private let socketManager = SocketIOManager.shared

    private let uid: String
    private let chats = BehaviorRelay<[Chat]>(value: [])
    private let lastDate = PublishRelay<String>()
    
    init(
        uid: String,
        networkProvider: NetworkProvider = NetworkProviderImpl(),
        chatRepository: ChatRepositoryImpl<Chat> = ChatRepositoryImpl<Chat>()
    ) {
        self.uid = uid
        self.networkProvider = networkProvider
        self.chatRepository = chatRepository
        
        listenSocket()
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.viewWillAppear
            .asDriver(onErrorJustReturn: ())
            .map { self.fetchLocalDBChat() }
            .drive()
            .disposed(by: disposeBag)
        
        input.sendButtonDidTap
            .withLatestFrom(input.chatText)
            .map { self.sendChat($0, to: self.uid) }
            .asDriver(onErrorJustReturn: ())
            .drive { _ in output.textViewContents.accept("") }
            .disposed(by: disposeBag)
        
        input.textViewBeginEditing
            .asDriver(onErrorJustReturn: ())
            .drive { _ in
                output.textViewContents.accept("")
            }
            .disposed(by: disposeBag)
        
        chats.asDriver()
            .drive(output.chats)
            .disposed(by: disposeBag)
        
        lastDate
            .map { self.fetchChatFromLastDate($0, from: self.uid) }
            .map { self.socketManager.establishConnection() }
            .asDriver(onErrorJustReturn: ())
            .drive()
            .disposed(by: disposeBag)
        
        return output
    }
}

extension ChatViewModel {
    struct Input {
        let viewWillAppear: Observable<Void>
        let sendButtonDidTap: Observable<Void>
        let chatText: Observable<String>
        let textViewBeginEditing: Observable<Void>
    }
    
    struct Output {
        let chats = BehaviorRelay<[Chat]>(value: [])
        let textViewContents = PublishRelay<String>()
    }
}

extension ChatViewModel {
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSS'Z"
        return dateFormatter
    }
    
    // 날짜 뽑아내는 로직을 ViewModel 단에서 작성해야할까?
    func extractDate(at chats: [Chat]) -> String {
        let defaultDateString = "2000-01-01T00:00:00.000Z"
        
        if chats.isEmpty {
            return defaultDateString
        } else {
            guard let date = chats.last?.date else { return defaultDateString }
            return dateFormatter.string(from: date)
        }
    }
    
    // DB
    func fetchLocalDBChat() {
        chatRepository.fetchChat(for: uid)
            .subscribe { chat in
                print("1️⃣ Realm DB 조회", chat)
                let lastDate = self.extractDate(at: chat)
                self.lastDate.accept(lastDate)
                self.chats.accept(chat)
            }
            .disposed(by: disposeBag)
    }
    
    // Server
    func fetchChatFromLastDate(_ date: String, from uid: String) {
        let chatAPI = FetchChatAPI(from: uid, lastchatDate: date)
        networkProvider.execute(of: chatAPI)
            .subscribe { chatResponseDTO in
                let chats = chatResponseDTO.payload.map({ dto in
                    dto.asDomain()
                })
                self.chats.accept(self.chats.value + chats)
                
            } onFailure: { error in
                print(error.localizedDescription, "🔥")
            }
            .disposed(by: disposeBag)
    }
    
    func sendChat(_ chat: String, to uid: String) {
        let sendAPI = SendChatAPI(to: uid, chat: chat)
        networkProvider.execute(of: sendAPI)
            .subscribe { chat in
                print("3️⃣ 전송 CHAT", chat)
                var newChat = self.chats.value
                newChat.append(chat.asDomain())
                self.chats.accept(newChat)
            } onFailure: { error in
                print(error.localizedDescription, "🔥")
            }
            .disposed(by: disposeBag)
    }
    
    func listenSocket() {
        socketManager.listener = { [self] data in
            print("4️⃣ 소켓 listen 시작", data)
            var newChat = chats.value
            newChat.append(data)
            self.chats.accept(newChat)
        }
    }
}
