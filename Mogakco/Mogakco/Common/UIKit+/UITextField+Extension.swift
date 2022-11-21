//
//  UITextField+Extension.swift
//  Mogakco
//
//  Created by taekki on 2022/11/10.
//

import UIKit

extension UITextField {
    
    func setTextColor(_ color: UIColor, font: UIFont) {
        self.textColor = color
        self.font = font
    }
    
    func setBottomBorder(with color: UIColor, width: CGFloat) {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: width)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
        
    func setPlaceHolderAttributes(placeHolderText: String, color: UIColor, font: UIFont) {
        self.attributedPlaceholder = NSAttributedString(string: placeHolderText, attributes: [.foregroundColor: color, .font: font])
    }
    
    func setLeftPadding(to padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
