//
//  SearchAPI.swift
//  Mogakco
//
//  Created by taekki on 2022/11/27.
//

import Foundation

struct SearchAPI: Encodable {
    let lat: Double
    let long: Double
}

extension SearchAPI: URLRequestable {
    typealias Response = SearchResponseDTO
    
    var url: String { baseURL + "/queue/search" }
    var method: HTTPMethod { .post }
    var parameters: Encodable? { self }
}
