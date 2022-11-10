//
//  NicknameViewController.swift
//  Mogakco
//
//  Created by taekki on 2022/11/10.
//

import UIKit

final class NicknameViewController: BaseViewController {
    
    private let textLabel = UILabel()
    private let textField = UITextField()
    private let verificationCodeButton = SSButton(.disable)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setAttributes() {
        view.backgroundColor = .Gray.white
        
        textLabel.do {
            $0.text = """
            닉네임을 입력해 주세요
            """
            $0.numberOfLines = 0
            $0.setTypoStyle(.display1, alignment: .center)
        }
        
        textField.do {
            $0.placeholder = "10자 이내로 입력"
            $0.font = .init(.regular, 14)
            $0.setBottomBorder(with: .Gray.gray3, width: 1)
            $0.becomeFirstResponder()
        }
        
        verificationCodeButton.do {
            $0.title = "다음"
        }
    }
    
    override func setHierarchy() {
        view.addSubview(textLabel)
        view.addSubview(textField)
        view.addSubview(verificationCodeButton)
    }
    
    override func setLayout() {
        textLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(125)
            $0.centerX.equalToSuperview()
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(textLabel.snp.bottom).offset(77)
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(47)
        }
        
        verificationCodeButton.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(72)
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
    }
}

extension NicknameViewController {
    
}
