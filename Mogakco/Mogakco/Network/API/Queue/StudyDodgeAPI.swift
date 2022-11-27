//
//  StudyDodgeAPI.swift
//  Mogakco
//
//  Created by taekki on 2022/11/28.
//

import Foundation

struct StudyDodgeAPI: Encodable {
    let otheruid: String
}

extension StudyDodgeAPI: URLRequestable {
    typealias Response = EmptyResponse
    
    var url: String { baseURL + "/queue/dodge" }
    var method: HTTPMethod { .post }
    var parameters: Encodable? { self }
}
