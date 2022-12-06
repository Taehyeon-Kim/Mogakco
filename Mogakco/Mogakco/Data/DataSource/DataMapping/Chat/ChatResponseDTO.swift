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
        
        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<ChatResponseDTO.ChatPayload.CodingKeys> = try decoder.container(keyedBy: ChatResponseDTO.ChatPayload.CodingKeys.self)
            self.id = try container.decode(String.self, forKey: ChatResponseDTO.ChatPayload.CodingKeys.id)
            self.to = try container.decode(String.self, forKey: ChatResponseDTO.ChatPayload.CodingKeys.to)
            self.from = try container.decode(String.self, forKey: ChatResponseDTO.ChatPayload.CodingKeys.from)
            self.chat = try container.decode(String.self, forKey: ChatResponseDTO.ChatPayload.CodingKeys.chat)
            self.createdAt = try container.decode(String.self, forKey: ChatResponseDTO.ChatPayload.CodingKeys.createdAt)
        }
    }
    
    let payload: [ChatPayload]
    
    enum CodingKeys: CodingKey {
        case payload
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.payload = try container.decodeIfPresent([ChatResponseDTO.ChatPayload].self, forKey: .payload) ?? []
    }
}

extension ChatResponseDTO.ChatPayload {
    
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSS'Z"
        return dateFormatter
    }
    
    func asDomain() -> Chat {
        return Chat(uid: from, chat: chat, date: dateFormatter.date(from: createdAt)!)
    }
}
