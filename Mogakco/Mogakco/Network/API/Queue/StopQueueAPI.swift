//
//  StopQueueAPI.swift
//  Mogakco
//
//  Created by taekki on 2022/11/28.
//

import Foundation

struct StopQueueAPI {}

extension StopQueueAPI: URLRequestable {
    typealias Response = EmptyResponse
    
    var url: String { baseURL + "/queue" }
    var method: HTTPMethod { .delete }
}
