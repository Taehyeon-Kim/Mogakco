//
//  NetworkError.swift
//  Mogakco
//
//  Created by taekki on 2022/11/11.
//

import Foundation

enum NetworkError: Error {
    case unknownError
    case componentsError
    case urlRequestError(Error)
    case serverError(InternalError)
    case emptyData
    case parsingError
    case decodingError(Error)
}

enum InternalError: Int {
    case invalidToken = 401         // Firebase Token Error
    case noUser = 406               // 회원탈퇴 혹은 미가입 유저
    case internalServerError = 500
    case clientError = 501
    case unknown
}
