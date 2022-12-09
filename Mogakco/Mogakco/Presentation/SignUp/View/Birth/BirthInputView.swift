//
//  BirthInputView.swift
//  Mogakco
//
//  Created by taekki on 2022/11/11.
//

import UIKit

import SnapKit

final class BirthInputView: BaseView {
    
    enum BirthType {
        case year, month, day
        
        var title: String {
            switch self {
            case .year: return "년"
            case .month: return "월"
            case .day: return "일"
            }
        }
        
        var placeholder: String {
            switch self {
            case .year: return "1990"
            case .month: return "1"
            case .day: return "1"
            }
        }
    }
    
    // MARK: UI
    private let textField = UITextField()
    private let titleLabel = UILabel()
    private let datePicker = UIDatePicker()

    // MARK: Property
    var placeholder: String? {
        get { textField.placeholder }
        set {
            textField.placeholder = newValue
            textField.setPlaceHolderAttributes(
                placeHolderText: newValue ?? "",
                color: .MGC.gray7,
                font: .init(.regular, 14))
        }
    }
    
    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var value: String? {
        get { textField.text }
        set { textField.text = newValue }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect = .zero, type: BirthType) {
        self.init(frame: frame)
        configure(type)
    }
    
    override func setAttributes() {
        textField.do {
            $0.setBottomBorder(with: .MGC.gray3, width: 1)
            $0.setLeftPadding(to: 12)
        }
        
        titleLabel.do {
            $0.setTypoStyle(.title2)
        }
        
        datePicker.do {
            $0.preferredDatePickerStyle = .wheels
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

extension BirthInputView {
    
    func configure(_ type: BirthType) {
        title = type.title
        placeholder = type.placeholder
    }
}
