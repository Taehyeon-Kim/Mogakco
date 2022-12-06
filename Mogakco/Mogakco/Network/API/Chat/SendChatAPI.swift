//
//  SendChatAPI.swift
//  Mogakco
//
//  Created by taekki on 2022/12/06.
//

import Foundation

struct SendChatAPI {
    let to: String
    let chat: String
}

struct SendChatAPIParameter: Encodable {
    let chat: String
}

extension SendChatAPI: URLRequestable {
    typealias Response = ChatResponseDTO.ChatPayload
    
    var url: String { baseURL + "/chat/\(to)" }
    var method: HTTPMethod { .post }
    var parameters: Encodable? { SendChatAPIParameter(chat: chat) }
}
