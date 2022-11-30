//
//  ChatInputView.swift
//  Mogakco
//
//  Created by taekki on 2022/11/30.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

final class ChatInputView: BaseView {
    
    let chatTextView = UITextView()
    let sendButton = UIButton()
    
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bind()
    }
    
    override func setAttributes() {
        sendButton.do {
            $0.setImage(.icnChatSend, for: .normal)
        }
        
        chatTextView.do {
            $0.text = "메시지를 입력하세요"
            $0.textColor = .MGC.gray7
            $0.backgroundColor = .clear
            $0.font = .notoSansR(14)
            $0.contentInset = .zero
            $0.textContainerInset = .zero
        }
    }
    
    override func setHierarchy() {
        addSubviews(chatTextView, sendButton)
    }
    
    override func setLayout() {
        chatTextView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(12)
            $0.trailing.equalToSuperview().inset(44)
            $0.directionalVerticalEdges.equalToSuperview().inset(14)
        }
        
        sendButton.snp.makeConstraints {
            $0.centerY.equalTo(chatTextView.snp.centerY)
            $0.trailing.equalToSuperview().inset(12)
            $0.size.equalTo(24)
        }
    }
    
    func bind() {

        chatTextView.rx.text.changed
            .bind { text in
                print(text)
            }
            .disposed(by: disposeBag)
    }
}
