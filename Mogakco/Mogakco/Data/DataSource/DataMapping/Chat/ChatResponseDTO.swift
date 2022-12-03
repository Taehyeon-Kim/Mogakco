//
//  ChatResponseDTO.swift
//  Mogakco
//
//  Created by taekki on 2022/12/03.
//

import Foundation

struct ChatResponseDTO: Decodable {
    
    struct ChatPayload: Decodable {
        let id: String
        let to: String
        let from: String
        let chat: String
        let createdAt: String
        
        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case to, from, chat, createdAt
        }
    }
    
    let payload: [ChatPayload]?
}
