//
//  HTTPError.swift
//  Mogakco
//
//  Created by taekki on 2022/11/22.
//

import Foundation

enum HTTPError: Error, Equatable {
    case specific(Error)
    case unknown(MGCError)
    case noResponse
    case unauthorized
    case noUser
    case serverError
    case badRequest
    case decodingError
    case requestFail
}

extension Equatable where Self: Error {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs as Error == rhs as Error
    }
}

public func == (lhs: Error, rhs: Error) -> Bool {
    guard type(of: lhs) == type(of: rhs) else { return false }
    let error1 = lhs as NSError
    let error2 = rhs as NSError
    return error1.domain == error2.domain && error1.code == error2.code && "\(lhs)" == "\(rhs)"
}
