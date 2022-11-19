//
//  NetworkError.swift
//  Mogakco
//
//  Created by taekki on 2022/11/11.
//

import Foundation

enum NetworkError: Error {
    case unknown
    case components
    case urlRequest(Error)
    case server(InternalError)
    case emptyData
    case parsing
    case decoding(Error)
}

enum InternalError: Int {
    case invalidToken = 401         // Firebase Token Error
    case noUser = 406               // 회원탈퇴 혹은 미가입 유저
    case internalServerError = 500
    case clientError = 501
    case unknown
}
