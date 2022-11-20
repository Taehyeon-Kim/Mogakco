//
//  MyPageAPI.swift
//  Mogakco
//
//  Created by taekki on 2022/11/20.
//

import Foundation

struct MyPageAPI: URLRequestable, Encodable {
    let searchable: Int
    let ageMin: Int
    let ageMax: Int
    let gender: Int
    let study: String?
}

extension MyPageAPI {
    typealias Response = EmptyResponse
    
    var url: String { baseURL + "/user/mypage" }
    var method: HTTPMethod { .put }
    var parameters: Encodable? { self }
}
