//
//  BirthInputView.swift
//  Mogakco
//
//  Created by taekki on 2022/11/11.
//

import UIKit

import SnapKit

final class BirthInputView: BaseView {
    
    private let textField = UITextField()
    private let titleLabel = UILabel()
    
    var placeholder: String? {
        get { textField.placeholder }
        set {
            textField.placeholder = newValue
            textField.setPlaceHolderAttributes(placeHolderText: newValue ?? "", color: .Gray.gray7, font: .init(.regular, 14))
        }
    }
    
    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    override func setAttributes() {
        textField.do {
            $0.setBottomBorder(with: .Gray.gray3, width: 1)
            $0.setLeftPadding(to: 12)
        }
        
        titleLabel.do {
            $0.setTypoStyle(.title2)
        }
    }
    
    override func setHierarchy() {
        addSubviews(textField, titleLabel)
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.width.equalTo(15)
            $0.height.equalTo(26)
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        textField.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(titleLabel.snp.leading).offset(-4)
            $0.directionalVerticalEdges.equalToSuperview()
        }
    }
}
