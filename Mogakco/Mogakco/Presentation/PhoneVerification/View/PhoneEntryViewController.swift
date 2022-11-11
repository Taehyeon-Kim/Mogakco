//
//  PhoneEntryViewController.swift
//  Mogakco
//
//  Created by taekki on 2022/11/10.
//

import UIKit

final class PhoneEntryViewController: BaseViewController {
    
    // MARK: Constants
    
    enum Metric {
        static let padding = 16.adjustedWidth
        static let textFieldLeftPadding = 12.0
        
        static let titleLabelTop = 125.adjustedHeight
        
        static let phoneEntryFieldTop = 65.adjustedHeight
        static let phoneEntryFieldHeight = 47.adjustedHeight
        
        static let verificationCodeButtonTop = 72.adjustedHeight
        static let verificationCodeButtonHeight = 48.adjustedHeight
    }
    
    enum Text {
        static let titleLabel = """
        새싹 서비스 이용을 위해
        휴대폰 번호를 입력해주세요
        """
        
        static let phoneEntryField = "휴대폰 번호(-없이 숫자만 입력)"
        static let verificationCodeButtonTitle = "인증 문자 받기"
    }
    
    // MARK: UI
    
    private let titleLabel = UILabel()
    private let phoneEntryField = UITextField()
    private let verificationCodeButton = SSButton(.disable)
    
    // MARK: Override Methods
   
    override func setAttributes() {
        view.backgroundColor = .Gray.white
        
        titleLabel.do {
            $0.numberOfLines = 0
            $0.text = Text.titleLabel
            $0.setTypoStyle(.display1, alignment: .center)
        }
        
        phoneEntryField.do {
            $0.placeholder = Text.phoneEntryField
            $0.font = .init(.regular, 14)
            $0.keyboardType = .numberPad
            $0.setBottomBorder(with: .Gray.gray3, width: 1)
            $0.setLeftPadding(to: Metric.textFieldLeftPadding)
            $0.becomeFirstResponder()
        }
        
        verificationCodeButton.do {
            $0.title = Text.verificationCodeButtonTitle
        }
    }
    
    override func setHierarchy() {
        view.addSubviews(titleLabel, phoneEntryField, verificationCodeButton)
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Metric.titleLabelTop)
            $0.centerX.equalToSuperview()
        }
        
        phoneEntryField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Metric.phoneEntryFieldTop)
            $0.directionalHorizontalEdges.equalToSuperview().inset(Metric.padding)
            $0.height.equalTo(Metric.phoneEntryFieldHeight)
        }
        
        verificationCodeButton.snp.makeConstraints {
            $0.top.equalTo(phoneEntryField.snp.bottom).offset(Metric.verificationCodeButtonTop)
            $0.directionalHorizontalEdges.equalToSuperview().inset(Metric.padding)
            $0.height.equalTo(Metric.verificationCodeButtonHeight)
        }
    }
}
