//
//  RealmChat.swift
//  Mogakco
//
//  Created by taekki on 2022/12/02.
//

import Realm
import RealmSwift

/// Realm Object - Chat
final class RealmChat: Object {
    @Persisted var uid: String
    @Persisted var chat: String
    @Persisted var date: Date = Date()
    
    @Persisted(primaryKey: true) var objectId: ObjectId
}

extension RealmChat: DomainConvertibleType {

    func asDomain() -> Chat {
        return Chat(uid: uid, chat: chat, date: date)
    }
}
