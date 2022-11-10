//
//  UIButton+Extension.swift
//  Mogakco
//
//  Created by taekki on 2022/11/11.
//

import UIKit

extension UIButton.Configuration {
    
    static func genderStyle(_ gender: GenderInputView.Gender) -> Self {
        var config = UIButton.Configuration.filled()
        config.image = gender == .man ? UIImage(named: "man") : UIImage(named: "woman")
        config.title = gender == .man ? "남자" : "여자"
        config.attributedTitle?.font = UIFont(.regular, 16)
        config.imagePlacement = .top
        config.imagePadding = 8
        config.titleAlignment = .center
        config.baseForegroundColor = .black
        config.baseBackgroundColor = .white
        config.background.cornerRadius = 8
        config.background.strokeColor = .Gray.gray3
        config.background.strokeWidth = 1
        return config
    }
}
