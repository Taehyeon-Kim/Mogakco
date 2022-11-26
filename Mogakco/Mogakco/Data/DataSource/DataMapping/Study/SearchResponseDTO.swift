//
//  SearchResponseDTO.swift
//  Mogakco
//
//  Created by taekki on 2022/11/27.
//

import Foundation

// MARK: - SearchResponseDTO
struct SearchResponseDTO: Codable {
    let fromQueueDB, fromQueueDBRequested: [FromQueueDB]
    let fromRecommend: [String]
}

// MARK: - FromQueueDB
struct FromQueueDB: Codable {
    let uid, nick: String
    let lat, long: Double
    let reputation: [Int]
    let studylist, reviews: [String]
    let gender, type, sesac, background: Int
}
