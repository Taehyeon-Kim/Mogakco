//
//  QueueStateDTO.swift
//  Mogakco
//
//  Created by taekki on 2022/11/28.
//

import Foundation

struct QueueStateDTO: Codable {
    let dodged: Int
    let matched: Int
    let reviewed: Int
    let matchedNick: String
    let matchedUid: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.dodged = try container.decode(Int.self, forKey: .dodged)
        self.matched = try container.decode(Int.self, forKey: .matched)
        self.reviewed = try container.decode(Int.self, forKey: .reviewed)
        self.matchedNick = try container.decodeIfPresent(String.self, forKey: .matchedNick) ?? ""
        self.matchedUid = try container.decodeIfPresent(String.self, forKey: .matchedUid) ?? ""
    }
}
