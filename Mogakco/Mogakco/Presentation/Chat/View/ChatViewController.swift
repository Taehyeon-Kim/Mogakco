//
//  ChatViewController.swift
//  Mogakco
//
//  Created by taekki on 2022/11/30.
//

import UIKit

import RxCocoa
import RxSwift

final class ChatViewController: BaseViewController {
    
    private let rootView = ChatView()
    private let viewModel: ChatViewModel
    
    init(viewModel: ChatViewModel) {
        self.viewModel = viewModel
    }
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    deinit {
        SocketIOManager.shared.closeConnection()
    }
}

extension ChatViewController: Bindable {
    func bind() {
        let input = ChatViewModel.Input(
            viewWillAppear: self.rx.methodInvoked(#selector(viewWillAppear)).map { _ in }.asObservable(),
            sendButtonDidTap: rootView.chatInputView.sendButton.rx.tap.asObservable(),
            chatText: rootView.chatInputView.chatTextView.rx.text.orEmpty.asObservable(),
            textViewBeginEditing: rootView.chatInputView.chatTextView.rx.didBeginEditing.asObservable()
        )
        let output = viewModel.transform(input: input)
        
        output.chats
            .bind(to: rootView.collectionView.rx.items) { collectionView, row, elem in
                let indexPath = IndexPath(row: row, section: 0)

                if UserDefaultsManager.uid == elem.uid {
                    let cell = collectionView.dequeueReusableCell(cellType: MyChatCell.self, for: indexPath)
                    cell.configure(with: elem.chat)
                    return cell
                } else {
                    let cell = collectionView.dequeueReusableCell(cellType: OpponentChatCell.self, for: indexPath)
                    cell.configure(with: elem.chat)
                    return cell
                }
            }
            .disposed(by: disposeBag)
        
        output.chats
            .bind { chats in
                self.rootView.collectionView.scrollToItem(at: IndexPath(row: chats.count - 1, section: 0), at: .bottom, animated: false)
            }
            .disposed(by: disposeBag)
        
        output.textViewContents
            .asDriver(onErrorJustReturn: "")
            .drive(onNext: { text in
                self.rootView.chatInputView.chatTextView.text = text
            })
            .disposed(by: disposeBag)
    }
}
