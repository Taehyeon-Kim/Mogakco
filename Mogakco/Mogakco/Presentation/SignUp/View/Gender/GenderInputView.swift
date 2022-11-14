//
//  GenderInputView.swift
//  Mogakco
//
//  Created by taekki on 2022/11/11.
//

import UIKit

import SnapKit
import Then

final class GenderInputView: BaseView {
    
    enum Gender: Int {
        case man = 0
        case woman = 1
    }
    
    private lazy var containerHStackView = UIStackView(arrangedSubviews: [manButton, womanButton])
    private let manButton = UIButton()
    private let womanButton = UIButton()
    
    override func setAttributes() {
        containerHStackView.do {
            $0.axis = .horizontal
            $0.spacing = 12
        }
        
        manButton.do {
            $0.tag = Gender.man.rawValue
            $0.configuration = .genderStyle(.man)
        }
        
        womanButton.do {
            $0.tag = Gender.woman.rawValue
            $0.configuration = .genderStyle(.woman)
        }
    }
    
    override func setHierarchy() {
        addSubview(containerHStackView)
    }
    
    override func setLayout() {
        containerHStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
