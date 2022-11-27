//
//  ReviewAPI.swift
//  Mogakco
//
//  Created by taekki on 2022/11/28.
//

import Foundation

struct ReviewAPI: Encodable {
    let otheruid: String
    let reputation: [Int]
    let comment: String
    
    struct Path {
        let path: String
    }
}

extension ReviewAPI: URLRequestable {
    typealias Response = EmptyResponse
    
    var url: String { baseURL + "queue/rate/\(ReviewAPI.Path.self)" }
    var method: HTTPMethod { .post }
    var parameters: Encodable? { self }
}
