//
//  PhoneEntryViewController.swift
//  Mogakco
//
//  Created by taekki on 2022/11/10.
//

import UIKit

final class PhoneEntryViewController: BaseViewController {
    
    private let textLabel = UILabel()
    private let phoneEntryField = UITextField()
    private let verificationCodeButton = SSButton(.disable)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setAttributes() {
        view.backgroundColor = .Gray.white
        
        textLabel.do {
            $0.text = """
            새싹 서비스 이용을 위해
            휴대폰 번호를 입력해주세요
            """
            $0.numberOfLines = 0
            $0.setTypoStyle(.display1, alignment: .center)
        }
        
        phoneEntryField.do {
            $0.placeholder = "휴대폰 번호(-없이 숫자만 입력)"
            $0.font = .init(.regular, 14)
            $0.keyboardType = .numberPad
        }
        
        verificationCodeButton.do {
            $0.title = "인증 문자 받기"
        }
    }
    
    override func setHierarchy() {
        view.addSubview(textLabel)
        view.addSubview(phoneEntryField)
        view.addSubview(verificationCodeButton)
    }
    
    override func setLayout() {
        textLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(125)
            $0.centerX.equalToSuperview()
        }
        
        phoneEntryField.snp.makeConstraints {
            $0.top.equalTo(textLabel.snp.bottom).offset(77)
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
        }
        
        verificationCodeButton.snp.makeConstraints {
            $0.top.equalTo(phoneEntryField.snp.bottom).offset(72)
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
    }
}

extension PhoneEntryViewController {
    
}
