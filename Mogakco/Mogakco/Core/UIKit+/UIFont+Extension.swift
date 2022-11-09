//
//  UIFont+Extension.swift
//  Mogakco
//
//  Created by taekki on 2022/11/09.
//

import UIKit

extension UIFont {
    
    convenience init(_ name: TypoStyle.FontType, _ size: CGFloat) {
        self.init(name: name.rawValue, size: size)!
    }
}
