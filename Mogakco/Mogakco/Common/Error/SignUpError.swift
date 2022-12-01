//
//  SignUpError.swift
//  Mogakco
//
//  Created by taekki on 2022/12/01.
//

import Foundation

/// 회원가입 관련 에러
/// 201: 이미 가입한 유저
/// 202: 사용 불가능한 닉네임
enum SignUpError: LocalizedError {
    case networkError
    case alreadyExist
    case invalidNickname
}

extension SignUpError {
    
    var errorDescription: String? {
        switch self {
        case .networkError:
            return "네트워크 오류입니다."
        case .alreadyExist:
            return "이미 가입한 유저입니다."
        case .invalidNickname:
            return "해당 닉네임은 사용할 수 없습니다."
        }
    }
}

extension SignUpError {
    
    init?(mgcError: MGCError) {
        switch mgcError.code {
        case 201:
            self = .alreadyExist
        case 202:
            self = .invalidNickname
        default:
            self = .networkError
        }
    }
}
