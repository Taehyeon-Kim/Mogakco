//
//  MGCHTTPError.swift
//  Mogakco
//
//  Created by taekki on 2022/11/15.
//

import Foundation

enum MGCHTTPError: Int, LocalizedError {
    
    // MARK: 4XX
    case unregistered = 406
    
    // MARK: 5XX
    case serverError = 500
    case badRequest = 501
}

extension MGCHTTPError {
    
    var errorDescription: String? {
        switch self {
        case .unregistered:
            return "🗣 :: 등록되지 않은 유저(미가입 유저 또는 회원탈퇴 유저)"
        case .serverError:
            return "🗣 :: 서버 에러"
        case .badRequest:
            return "🗣 :: 요청 에러(Header 또는 RequestBody 확인바람)"
        }
    }
}
