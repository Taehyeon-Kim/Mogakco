//
//  MGCNetworkError.swift
//  Mogakco
//
//  Created by taekki on 2022/11/15.
//

import Foundation

enum MGCNetworkError: LocalizedError {
    case cancelled
    case mgcError(MGCError)
    case unknown(Error)
}

extension MGCNetworkError {
    
    var errorDescription: String? {
        switch self {
        case .cancelled:
            return "🌐 네트워크 요청 취소!"
        case .mgcError(let mgcError):
            return "🌐 MGCError :: \(mgcError.localizedDescription)"
        case .unknown(let error):
            return "🌐 알 수 없는 에러 :: \(error.localizedDescription)"
        }
    }
}
