//
//  FindQueueAPI.swift
//  Mogakco
//
//  Created by taekki on 2022/11/22.
//

import Foundation

struct FindQueueAPI: Encodable {
    typealias Study = String
    
    let long: Double
    let lat: Double
    let studylist: [Study]
}

extension FindQueueAPI: URLRequestable {
    typealias Response = Data
    
    var url: String { baseURL + "/queue" }
    var method: HTTPMethod { .post }
    var parameters: Encodable? { self }
}
