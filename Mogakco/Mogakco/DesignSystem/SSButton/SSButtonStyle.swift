//
//  SSButtonStyle.swift
//  Mogakco
//
//  Created by taekki on 2022/11/08.
//

import UIKit

enum SSButtonStyle {
    case inactive
    case fill
    case outline
    case cancel
    case disable
    
    var titleColor: UIColor? {
        switch self {
        case .inactive:
            return .Gray.black
        case .fill:
            return .Gray.white
        case .outline:
            return .Brand.green
        case .cancel:
            return .Gray.black
        case .disable:
            return .Gray.gray3
        }
    }
    
    var backgroundColor: UIColor? {
        switch self {
        case .inactive:
            return .Gray.white
        case .fill:
            return .Brand.green
        case .outline:
            return .Gray.white
        case .cancel:
            return .Gray.gray2
        case .disable:
            return .Gray.gray6
        }
    }
}
