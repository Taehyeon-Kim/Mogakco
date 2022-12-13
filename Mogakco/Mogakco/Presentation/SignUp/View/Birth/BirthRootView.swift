//
//  BirthRootView.swift
//  Mogakco
//
//  Created by taekki on 2022/12/09.
//

import UIKit

import RxCocoa
import RxSwift

/// BirthViewController의 RootView UI를 담당
final class BirthRootView: BaseView {
    
    // MARK: Literal
    enum Literal {
        static let message = "생년월일을 알려주세요"
        static let nextButtonTitle = "다음"
    }
    
    // MARK: UI
    let navigationBar = MGCNavigationBar()
    let messageLabel = UILabel()
    
    let birthInputStack = UIStackView()
    let yearInputView = BirthInputView(type: .year)
    let monthInputView = BirthInputView(type: .month)
    let dayInputView = BirthInputView(type: .day)
    
    let datePicker = UIDatePicker()
    let datePickerButton = CustomInputButton()
    let doneButton = UIBarButtonItem(systemItem: .done)
    
    let nextButton = MGCButton(.disable)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createDatePicker()
    }
    
    // MARK: Configure UI
    override func setAttributes() {
        backgroundColor = .MGC.white
        
        navigationBar.do {
            $0.leftBarItem = .back
        }
        
        messageLabel.do {
            $0.text = Literal.message
            $0.numberOfLines = 0
            $0.setTypoStyle(.display1, alignment: .center)
        }
        
        birthInputStack.do {
            $0.axis = .horizontal
            $0.spacing = 4
            $0.distribution = .fillEqually
        }
        
        nextButton.do {
            $0.title = Literal.nextButtonTitle
        }
    }
    
    override func setHierarchy() {
        birthInputStack.addArrangedSubviews(yearInputView, monthInputView, dayInputView)
        addSubviews(navigationBar, messageLabel, birthInputStack, datePickerButton, nextButton)
    }
    
    override func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(97)
            $0.centerX.equalToSuperview()
        }
        
        birthInputStack.snp.makeConstraints {
            $0.top.equalTo(messageLabel.snp.bottom).offset(80)
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
        
        datePickerButton.snp.makeConstraints {
            $0.edges.equalTo(birthInputStack)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(birthInputStack.snp.bottom).offset(72)
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
    }
}

// MARK: Private Function
extension BirthRootView {
    
    private func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.setItems([doneButton], animated: true)

        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        datePickerButton.inputAccessoryView = toolbar
        datePickerButton.inputView = datePicker
    }
}
