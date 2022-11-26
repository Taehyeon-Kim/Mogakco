//
//  KeywordError.swift
//  Mogakco
//
//  Created by taekki on 2022/11/26.
//

import Foundation

enum KeywordError: LocalizedError {
    case outOfKeywordNumber
    case outOfKeywordLength
    case duplicated
}

extension KeywordError {
    
    var errorDescription: String? {
        switch self {
        case .outOfKeywordNumber:
            return "최대 8개까지 스터디를 추가할 수 있습니다."
        case .outOfKeywordLength:
            return "최소 1글자 이상, 최대 8글자까지 작성 가능합니다."
        case .duplicated:
            return "이미 등록된 스터디입니다."
        }
    }
}
