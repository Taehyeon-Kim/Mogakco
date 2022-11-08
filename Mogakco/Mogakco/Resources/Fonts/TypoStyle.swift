//
//  TypoStyle.swift
//  Mogakco
//
//  Created by taekki on 2022/11/08.
//

import UIKit

enum TypoStyle {
    
    enum FontType: String {
        case medium = "NotoSansCJKkr-Medium"
        case regular = "NotoSansCJKkr-Regular"
    }

    struct TypoDescription {
        typealias FontSize = CGFloat
        typealias LineHeight = CGFloat
        
        let type: FontType
        let size: FontSize
        let lineHeight: LineHeight
    }

    case display1
    case title1, title2, title3, title4, title5, title6
    case body1, body2, body3, body4
    case caption
}

extension TypoStyle {
    
    var typoDescription: TypoDescription {
        switch self {
        case .display1:
            return .init(type: .regular, size: 20, lineHeight: 1.6)
        case .title1:
            return .init(type: .medium, size: 16, lineHeight: 1.6)
        case .title2:
            return .init(type: .regular, size: 16, lineHeight: 1.6)
        case .title3:
            return .init(type: .medium, size: 14, lineHeight: 1.6)
        case .title4:
            return .init(type: .regular, size: 14, lineHeight: 1.6)
        case .title5:
            return .init(type: .medium, size: 12, lineHeight: 1.5)
        case .title6:
            return .init(type: .regular, size: 12, lineHeight: 1.5)
        case .body1:
            return .init(type: .medium, size: 16, lineHeight: 1.85)
        case .body2:
            return .init(type: .regular, size: 16, lineHeight: 1.85)
        case .body3:
            return .init(type: .regular, size: 14, lineHeight: 1.7)
        case .body4:
            return .init(type: .regular, size: 12, lineHeight: 1.8)
        case .caption:
            return .init(type: .regular, size: 10, lineHeight: 1.6)
        }
    }
    
    var font: UIFont {
        guard
            let font = UIFont(name: typoDescription.type.rawValue, size: typoDescription.size)
        else {
            return UIFont()
        }
        return font
    }
}
