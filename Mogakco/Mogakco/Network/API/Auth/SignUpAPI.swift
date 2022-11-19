//
//  SignUpAPI.swift
//  Mogakco
//
//  Created by taekki on 2022/11/19.
//

import Foundation

struct SignUpAPI: URLRequestable, Encodable {
    var phoneNumber: String
    var fcmToken: String
    var nick: String
    var birth: String
    var email: String
    var gender: Int
    
    enum CodingKeys: String, CodingKey {
        case phoneNumber, nick, birth, email, gender
        case fcmToken = "FCMtoken"
    }
}

extension SignUpAPI {
    typealias Response = EmptyResponse

    var url: String { baseURL + "/user" }
    var method: HTTPMethod { .post }
    var parameters: Encodable? { self }
}
