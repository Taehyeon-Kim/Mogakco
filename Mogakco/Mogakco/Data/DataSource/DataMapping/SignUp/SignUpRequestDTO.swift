//
//  SignUpRequestDTO.swift
//  Mogakco
//
//  Created by taekki on 2022/11/15.
//

import Foundation

// {
//   "phoneNumber" : "+821012345678",
//   "FCMtoken" : "dzjnejNDh0d0u1aLzfS547:APA91bFvQSjDVFC4-2IA0QQ08KqsEKwIoK2hFBZIfdyNLPd22PvgLD6YM_kyQgv0BIK-1zjltbbKYQTGK50Pn21bctsuEC46qo7RDkcImbzyZBe0-ffMqhFhL4DO5tbP0Ri_Wn-vRVF5",
//   "nick": "고래밥",
//   "birth": "2002-01-16T09:23:44.054Z",
//   "email": "user@example.com",
//   "gender" : 0
// }

struct SignUpRequestDTO: Encodable, Equatable {
    var phoneNumber: String
    var FCMtoken: String
    var nick: String
    var birth: String
    var email: String
    var gender: Int
    
    // enum CodingKeys: String, CodingKey {
    //     case phoneNumber, nick, birth, email, gender
    //     case fcmToken = "FCMtoken"
    // }
}
