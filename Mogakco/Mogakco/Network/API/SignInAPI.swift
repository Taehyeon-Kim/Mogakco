//
//  SignInAPI.swift
//  Mogakco
//
//  Created by taekki on 2022/11/19.
//

import Foundation

struct SignInAPI: URLRequestable {
    typealias Response = UserResponseDTO

    var url: String { baseURL + "/user" }
    var method: HTTPMethod { .get }
}
