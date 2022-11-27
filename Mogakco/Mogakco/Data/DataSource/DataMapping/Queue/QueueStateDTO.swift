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
}
