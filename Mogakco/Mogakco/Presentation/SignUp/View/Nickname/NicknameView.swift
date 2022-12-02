//
//  NicknameView.swift
//  Mogakco
//
//  Created by taekki on 2022/12/02.
//

import UIKit

final class NicknameView: BaseView {
    
    // MARK: UI
    let navigationBar = MGCNavigationBar()
    let textLabel = UILabel()
    let textField = UITextField()
    let nextButton = MGCButton(.disable)
    
    // MARK: Layout
    override func setAttributes() {
        backgroundColor = .MGC.white
        
        navigationBar.do {
            $0.leftBarItem = .back
        }
        
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
            $0.setBottomBorder(with: .MGC.gray3, width: 1)
            $0.setLeftPadding(to: 12)
            $0.becomeFirstResponder()
        }
        
        nextButton.do {
            $0.title = "다음"
        }
    }
    
    override func setHierarchy() {
        addSubviews(navigationBar, textLabel, textField, nextButton)
    }
    
    override func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        textLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(125)
            $0.centerX.equalToSuperview()
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(textLabel.snp.bottom).offset(77)
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(47)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(72)
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
    }
}
