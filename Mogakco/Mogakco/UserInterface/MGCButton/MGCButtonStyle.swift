//
//  MGCButtonStyle.swift
//  Mogakco
//
//  Created by taekki on 2022/11/08.
//

import UIKit

enum MGCButtonStyle {
    case inactive
    case fill
    case outline
    case cancel
    case disable
    
    var titleColor: UIColor? {
        switch self {
        case .inactive:
            return .MGC.black
        case .fill:
            return .MGC.white
        case .outline:
            return .MGC.green
        case .cancel:
            return .MGC.black
        case .disable:
            return .MGC.gray3
        }
    }
    
    var backgroundColor: UIColor? {
        switch self {
        case .inactive:
            return .MGC.white
        case .fill:
            return .MGC.green
        case .outline:
            return .MGC.white
        case .cancel:
            return .MGC.gray2
        case .disable:
            return .MGC.gray6
        }
    }
}
