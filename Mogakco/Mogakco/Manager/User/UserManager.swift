//
//  UserManager.swift
//  Mogakco
//
//  Created by taekki on 2022/12/02.
//

import Foundation

protocol UserManager {
    var userInfo: UserInfo { get }
    
    func store(nickname: String)
    func store(birth: String)
    func store(email: String)
    func store(gender: Int)
}

final class UserManagerImpl: UserManager {
    
    static let shared = UserManagerImpl()
    var userInfo: UserInfo = UserInfo(nickname: "", birth: "", email: "", gender: 0)
    
    private init() {}

    func store(nickname: String) {
        self.userInfo.nickname = nickname
    }
    
    func store(birth: String) {
        self.userInfo.birth = birth
    }
    
    func store(email: String) {
        self.userInfo.email = email
    }
    
    func store(gender: Int) {
        self.userInfo.gender = gender
    }
}

struct UserInfo {
    var nickname: String
    var birth: String
    var email: String
    var gender: Int
}
