//
//  StudyAcceptAPI.swift
//  Mogakco
//
//  Created by taekki on 2022/11/28.
//

import Foundation

struct StudyAcceptAPI: Encodable {
    let otheruid: String
}

extension StudyAcceptAPI: URLRequestable {
    typealias Response = EmptyResponse
    
    var url: String { baseURL + "/queue/studyaccept" }
    var method: HTTPMethod { .post }
    var parameters: Encodable? { self }
}
