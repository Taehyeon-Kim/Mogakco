//
//  FetchChatAPI.swift
//  Mogakco
//
//  Created by taekki on 2022/12/03.
//

import Foundation

struct FetchChatAPI {
    let from: String
    let lastchatDate: String
}

struct FetchChatAPIQuery: Encodable {
    let lastchatDate: String
}

extension FetchChatAPI: URLRequestable {
    typealias Response = ChatResponseDTO
    
    var url: String { baseURL + "/chat/\(from)" }
    var method: HTTPMethod { .get }
    var queryItems: Encodable? { FetchChatAPIQuery(lastchatDate: lastchatDate) }
}
