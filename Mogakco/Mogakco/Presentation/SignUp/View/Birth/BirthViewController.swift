//
//  BirthViewController.swift
//  Mogakco
//
//  Created by taekki on 2022/11/10.
//

import UIKit

final class BirthViewController: BaseViewController {
    
    private let textLabel = UILabel()
    private lazy var containerHStackView = UIStackView(arrangedSubviews: [yearInputView, monthInputView, dayInputView])
    private let yearInputView = BirthInputView()
    private let monthInputView = BirthInputView()
    private let dayInputView = BirthInputView()
    private let verificationCodeButton = SSButton(.disable)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setAttributes() {
        view.backgroundColor = .Gray.white
        
        textLabel.do {
            $0.text = """
            생년월일을 알려주세요
            """
            $0.numberOfLines = 0
            $0.setTypoStyle(.display1, alignment: .center)
        }
        
        containerHStackView.do {
            $0.axis = .horizontal
            $0.spacing = 4
            $0.distribution = .fillEqually
        }

        yearInputView.do {
            $0.title = "년"
            $0.placeholder = "1990"
        }
        
        monthInputView.do {
            $0.title = "월"
            $0.placeholder = "1"
        }
        
        dayInputView.do {
            $0.title = "일"
            $0.placeholder = "1"
        }
        
        verificationCodeButton.do {
            $0.title = "다음"
        }
    }
    
    override func setHierarchy() {
        view.addSubview(textLabel)
        view.addSubview(containerHStackView)
        view.addSubview(verificationCodeButton)
    }
    
    override func setLayout() {
        textLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(97)
            $0.centerX.equalToSuperview()
        }
        
        containerHStackView.snp.makeConstraints {
            $0.top.equalTo(textLabel.snp.bottom).offset(80)
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
        
        verificationCodeButton.snp.makeConstraints {
            $0.top.equalTo(containerHStackView.snp.bottom).offset(72)
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
    }
}
