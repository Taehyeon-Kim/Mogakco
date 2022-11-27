//
//  StudyRequestAPI.swift
//  Mogakco
//
//  Created by taekki on 2022/11/28.
//

import Foundation

struct StudyRequestAPI: Encodable {
    let otheruid: String
}

extension StudyRequestAPI: URLRequestable {
    typealias Response = EmptyResponse
    
    var url: String { baseURL + "/queue/studyrequest" }
    var method: HTTPMethod { .post }
    var parameters: Encodable? { self }
}
