//
//  UILabel+Extension.swift
//  Mogakco
//
//  Created by taekki on 2022/11/08.
//

import UIKit

extension UILabel {

    @discardableResult
    func setTypoStyle(_ typoStyle: TypoStyle, alignment: NSTextAlignment = .left, textColor: UIColor = .MGC.black) -> Self {
        let font = typoStyle.font
        let lineHeight = font.pointSize * typoStyle.typoDescription.lineHeight

        if let labelText = text, !labelText.isEmpty {
            let style = NSMutableParagraphStyle()
            style.maximumLineHeight = lineHeight
            style.minimumLineHeight = lineHeight
            style.alignment = alignment
            
            let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: style,
                .baselineOffset: (lineHeight - font.lineHeight) / 2,
                .font: font,
                .foregroundColor: textColor
            ]
            
            let attributedString = NSAttributedString(
                string: labelText,
                attributes: attributes
            )
            
            self.attributedText = attributedString
        }
        
        return self
    }
}

extension UILabel {
    
    func highlight(_ text: String, color: UIColor) {
        guard let labelText = self.text else { return }
        let range = (labelText as NSString).range(of: text)

        let mutableAttributedString = NSMutableAttributedString.init(string: labelText)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        self.attributedText = mutableAttributedString
    }
}
