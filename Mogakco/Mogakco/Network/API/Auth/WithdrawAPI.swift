//
//  WithdrawAPI.swift
//  Mogakco
//
//  Created by taekki on 2022/11/19.
//

import Foundation

struct WithdrawAPI: URLRequestable {}

extension WithdrawAPI {
    typealias Response = EmptyResponse

    var url: String { baseURL + "/user/withdraw" }
    var method: HTTPMethod { .post }
}
