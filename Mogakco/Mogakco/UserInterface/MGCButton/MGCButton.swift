//
//  MGCButton.swift
//  Mogakco
//
//  Created by taekki on 2022/11/08.
//

import UIKit

import SnapKit
import Then

final class MGCButton: BaseView {
    
    var button = UIButton()

    var actionHandler: (() -> Void)?

    var title: String? {
        get { button.titleLabel?.text }
        set { button.setTitle(newValue, for: .normal) }
    }
    
    var buttonStyle: MGCButtonStyle {
        didSet {
            updateUI(buttonStyle)
        }
    }
    
    var isEnabled: Bool {
        return buttonStyle != .disable
    }
    
    init(_ buttonStyle: MGCButtonStyle) {
        self.buttonStyle = buttonStyle
        super.init(frame: .zero)
        updateUI(buttonStyle)
    }

    override func setAttributes() {
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        
        button.do {
            $0.titleLabel?.font = TypoStyle.body3.font
            $0.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        }
    }
    
    override func setLayout() {
        addSubview(button)
        
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func updateUI(_ buttonStyle: MGCButtonStyle) {
        button.backgroundColor = buttonStyle.backgroundColor
        button.setTitleColor(buttonStyle.titleColor, for: .normal)
        button.isEnabled = buttonStyle != .disable
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        actionHandler?()
    }
}
