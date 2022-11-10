//
//  EmailViewController.swift
//  Mogakco
//
//  Created by taekki on 2022/11/10.
//

import UIKit

final class EmailViewController: BaseViewController {
    
    private let textLabel = UILabel()
    private let subtextLabel = UILabel()
    private let phoneEntryField = UITextField()
    private let verificationCodeButton = SSButton(.disable)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setAttributes() {
        view.backgroundColor = .Gray.white
        
        textLabel.do {
            $0.text = "이메일을 입력해 주세요"
            $0.numberOfLines = 0
            $0.setTypoStyle(.display1, alignment: .center)
        }
        
        subtextLabel.do {
            $0.text = "휴대폰 번호 변경 시 인증을 위해 사용해요"
            $0.numberOfLines = 0
            $0.setTypoStyle(.title2, alignment: .center)
            $0.textColor = .Gray.gray7
        }
        
        phoneEntryField.do {
            $0.placeholder = "SeSAC@email.com"
            $0.font = .init(.regular, 14)
            $0.keyboardType = .numberPad
            $0.setBottomBorder(with: .Gray.gray3, width: 1)
            $0.becomeFirstResponder()
        }
        
        verificationCodeButton.do {
            $0.title = "다음"
        }
    }
    
    override func setHierarchy() {
        view.addSubview(textLabel)
        view.addSubview(subtextLabel)
        view.addSubview(phoneEntryField)
        view.addSubview(verificationCodeButton)
    }
    
    override func setLayout() {
        textLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(80)
            $0.centerX.equalToSuperview()
        }
        
        subtextLabel.snp.makeConstraints {
            $0.top.equalTo(textLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        phoneEntryField.snp.makeConstraints {
            $0.top.equalTo(textLabel.snp.bottom).offset(77)
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(47)
        }
        
        verificationCodeButton.snp.makeConstraints {
            $0.top.equalTo(phoneEntryField.snp.bottom).offset(72)
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
    }
}

extension EmailViewController {
    
}
