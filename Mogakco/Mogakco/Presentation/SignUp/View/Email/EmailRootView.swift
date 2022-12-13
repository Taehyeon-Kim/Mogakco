//
//  EmailRootView.swift
//  Mogakco
//
//  Created by taekki on 2022/12/13.
//

import UIKit

import RxCocoa
import RxSwift

/// BirthViewController의 RootView UI를 담당
final class EmailRootView: BaseView {
    
    // MARK: Literal
    enum Literal {
        static let title = "이메일을 입력해 주세요"
        static let subTitle = "휴대폰 번호 변경 시 인증을 위해 사용해요"
        static let placeholder = "SeSAC@email.com"
        static let nextButtonTitle = "다음"
    }
    
    // MARK: UI
    let navigationBar = MGCNavigationBar()
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    let textField = UITextField()
    let nextButton = MGCButton(.disable)

    // MARK: Configure UI
    override func setAttributes() {
        backgroundColor = .MGC.white
        
        navigationBar.do {
            $0.leftBarItem = .back
        }
        
        titleLabel.do {
            $0.text = Literal.title
            $0.numberOfLines = 0
            $0.setTypoStyle(.display1, alignment: .center)
        }
        
        subTitleLabel.do {
            $0.text = Literal.subTitle
            $0.numberOfLines = 0
            $0.setTypoStyle(.title2, alignment: .center)
            $0.textColor = .MGC.gray7
        }
        
        textField.do {
            $0.placeholder = Literal.placeholder
            $0.font = .init(.regular, 14)
            $0.setBottomBorder(with: .MGC.gray3, width: 1)
            $0.setLeftPadding(to: 12)
            $0.becomeFirstResponder()
        }
        
        nextButton.do {
            $0.title = Literal.nextButtonTitle
        }
    }
    
    override func setHierarchy() {
        addSubviews(
            navigationBar,
            titleLabel,
            subTitleLabel,
            textField,
            nextButton
        )
    }
    
    override func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(80)
            $0.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(77)
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
