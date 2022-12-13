//
//  GenderRootView.swift
//  Mogakco
//
//  Created by taekki on 2022/12/13.
//

import UIKit

import RxCocoa
import RxSwift

/// BirthViewController의 RootView UI를 담당
final class GenderRootView: BaseView {
    
    // MARK: Literal
    enum Literal {
        static let title = "성별을 선택해 주세요"
        static let subTitle = "새싹 찾기 기능을 이용하기 위해서 필요해요!"
        static let nextButtonTitle = "다음"
    }
    
    // MARK: UI
    let navigationBar = MGCNavigationBar()
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    let genderView = GenderInputView()
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
        
        nextButton.do {
            $0.title = Literal.nextButtonTitle
        }
    }
    
    override func setHierarchy() {
        addSubviews(
            navigationBar,
            titleLabel,
            subTitleLabel,
            genderView,
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
        
        genderView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(32)
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(120)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(genderView.snp.bottom).offset(32)
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
    }
}
