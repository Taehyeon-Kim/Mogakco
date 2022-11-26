//
//  KeywordViewSection.swift
//  Mogakco
//
//  Created by taekki on 2022/11/26.
//

import Foundation

enum KeywordViewSection: CaseIterable {
    case recommended
    case wanted
}

extension KeywordViewSection {
    
    var title: String {
        switch self {
        case .recommended:
            return "지금 주변에는"
        case .wanted:
            return "내가 하고 싶은"
        }
    }
}
