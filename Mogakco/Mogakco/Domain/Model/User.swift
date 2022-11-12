//
//  User.swift
//  Mogakco
//
//  Created by taekki on 2022/11/13.
//

import Foundation

struct User: Equatable {
    let userID: String
    let fcmToken: String
    let phoneNumber, email, nickname, birth: String
    let gender: Int
    let study: String
    let comment: [String]
    let reputation: [Int]
    let sesac: SesacImageCase
    let sesacCollection: [Int]
    let background: SesacBackgroundCase
    let backgroundCollection: [Int]
    let purchaseToken, transactionID, reviewedBefore: [String]
    let reportedNum: Int
    let reportedUser: [String]
    let dodgepenalty, dodgeNum, ageMin, ageMax: Int
    let searchable: Int
    let createdAt: String
}
