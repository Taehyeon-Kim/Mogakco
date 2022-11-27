//
//  MyQueueStateAPI.swift
//  Mogakco
//
//  Created by taekki on 2022/11/28.
//

import Foundation

struct MyQueueStateAPI {}

extension MyQueueStateAPI: URLRequestable {
    typealias Response = QueueStateDTO
    
    var url: String { baseURL + "/queue/myQueueState" }
    var method: HTTPMethod { .get }
}
