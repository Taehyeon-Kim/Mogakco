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
    
    // Static Methods
    static func notoSansR(_ size: CGFloat) -> UIFont {
        return UIFont(.regular, size)
    }
    
    static func notoSansM(_ size: CGFloat) -> UIFont {
        return UIFont(.medium, size)
    }
}

// MARK: Line Height(행 간격)
extension UILabel {
    
    func setLineHeight(_ lineHeight: CGFloat) {
        if let text = self.text {
            let attributedString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            style.maximumLineHeight = lineHeight
            style.minimumLineHeight = lineHeight

            attributedString.addAttribute(
                NSAttributedString.Key.paragraphStyle,
                value: style,
                range: .init(location: 0, length: attributedString.length)
            )
            
            /// notosans 폰트는 2로 나누어주어야 수직 중앙 정렬이 됨
            attributedString.addAttribute(
                .baselineOffset,
                value: (lineHeight - font.lineHeight) / 2,
                range: .init(location: 0, length: attributedString.length)
            )
            
            self.attributedText = attributedString
        }
    }
}
