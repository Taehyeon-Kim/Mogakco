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
    private let networkProvider = NetworkProviderImpl()
    private let chatRepository = ChatRepositoryImpl<Chat>()
    private let socketManager = SocketIOManager.shared
    
    private let myuid = "27MExocZoaX2BwYAPOMNZJp1mjY2"
    private let uid = "I8926rjKaTTzkqCE8PSXZ34YKjP2"
    private let chats = BehaviorRelay<[Chat]>(value: [])
    private let lastDate = PublishRelay<String>()
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.viewWillAppear
            .asDriver(onErrorJustReturn: ())
            .map { self.fetchLocalDBChat() }
            .drive()
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
        
        input.sendButtonDidTap
            .subscribe { _ in
                print("did Tap")
            }
            .disposed(by: disposeBag)
        
        return output
    }
}

extension ChatViewModel {
    struct Input {
        let viewWillAppear: Observable<Void>
        let sendButtonDidTap: Observable<Void>
    }
    
    struct Output {
        let chats = BehaviorRelay<[Chat]>(value: [])
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
                print(chatResponseDTO)
                let chats = chatResponseDTO.payload.map({ dto in
                    dto.asDomain()
                })
                print("2️⃣ 네트워크 마지막 날짜 기준 조회", chats)
                self.chats.accept(chats)
                
            } onFailure: { error in
                print(error.localizedDescription, "🔥")
            }
            .disposed(by: disposeBag)
    }
}
