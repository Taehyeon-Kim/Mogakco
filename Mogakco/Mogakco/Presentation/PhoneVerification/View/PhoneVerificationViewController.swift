//
//  PhoneVerificationViewController.swift
//  Mogakco
//
//  Created by taekki on 2022/11/10.
//

import UIKit

final class PhoneVerificationViewController: BaseViewController {

    private let textLabel = UILabel()
    private lazy var hStackView = UIStackView(
        arrangedSubviews: [phoneEntryField, resendButton])
    private let phoneEntryField = UITextField()
    private let resendButton = SSButton(.fill)
    private let verificationCodeButton = SSButton(.disable)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setAttributes() {
        view.backgroundColor = .Gray.white
        
        textLabel.do {
            $0.text = "인증번호가 문자로 전송되었어요"
            $0.numberOfLines = 0
            $0.setTypoStyle(.display1, alignment: .center)
        }
        
        hStackView.do {
            $0.axis = .horizontal
            $0.spacing = 12
        }
        
        resendButton.do {
            $0.title = "재전송"
        }
        
        phoneEntryField.do {
            $0.placeholder = "인증번호 입력"
            $0.font = .init(.regular, 14)
            $0.keyboardType = .numberPad
            $0.setBottomBorder(with: .Gray.gray3, width: 1)
            $0.becomeFirstResponder()
        }
        
        verificationCodeButton.do {
            $0.title = "인증하고 시작하기"
        }
    }
    
    override func setHierarchy() {
        view.addSubview(textLabel)
        view.addSubview(hStackView)
        view.addSubview(verificationCodeButton)
    }
    
    override func setLayout() {
        textLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(125)
            $0.centerX.equalToSuperview()
        }
        
        hStackView.snp.makeConstraints {
            $0.top.equalTo(textLabel.snp.bottom).offset(77)
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(47)
        }
        
        resendButton.snp.makeConstraints {
            $0.width.equalTo(72)
        }
        
        verificationCodeButton.snp.makeConstraints {
            $0.top.equalTo(phoneEntryField.snp.bottom).offset(72)
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
    }
}

extension PhoneVerificationViewController {
    
}
