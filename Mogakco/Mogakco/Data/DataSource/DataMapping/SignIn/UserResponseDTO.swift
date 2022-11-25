//
//  UserResponseDTO.swift
//  Mogakco
//
//  Created by taekki on 2022/11/13.
//

import Foundation

struct UserResponseDTO: Codable {
    let id: String
    let uid, phoneNumber, email, fcmToken: String
    let nick, birth: String
    let gender: Int
    let study: String
    let comment: [String]
    let reputation: [Int]
    let sesac: Int
    let sesacCollection: [Int]
    let background: Int
    let backgroundCollection: [Int]
    let purchaseToken, transactionID, reviewedBefore: [String]
    let reportedNum: Int
    let reportedUser: [String]
    let dodgepenalty, dodgeNum, ageMin, ageMax: Int
    let searchable: Int
    let createdAt: String

    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case uid, phoneNumber, email
        case fcmToken = "FCMtoken"
        case nick, birth, gender, study, comment, reputation, sesac, sesacCollection, background, backgroundCollection, purchaseToken
        case transactionID = "transactionId"
        case reviewedBefore, reportedNum, reportedUser, dodgepenalty, dodgeNum, ageMin, ageMax, searchable, createdAt
    }
}

extension UserResponseDTO {
    
    func toDomain() -> User {
        return User(
            userID: uid,
            fcmToken: fcmToken,
            phoneNumber: phoneNumber,
            email: email,
            nickname: nick,
            birth: birth,
            gender: gender,
            study: study,
            comment: comment,
            reputation: reputation,
            sesac: sesac,
            sesacCollection: sesacCollection,
            background: background,
            backgroundCollection: backgroundCollection,
            purchaseToken: purchaseToken,
            transactionID: transactionID,
            reviewedBefore: reviewedBefore,
            reportedNum: reportedNum,
            reportedUser: reportedUser,
            dodgepenalty: dodgepenalty,
            dodgeNum: dodgeNum,
            ageMin: ageMin,
            ageMax: ageMax,
            searchable: searchable,
            createdAt: createdAt
        )
    }
}
