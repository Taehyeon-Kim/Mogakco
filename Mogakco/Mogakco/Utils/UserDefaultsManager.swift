//
//  UserDefaultsManager.swift
//  Mogakco
//
//  Created by taekki on 2022/11/11.
//

import Foundation

@propertyWrapper
struct UserDefaultsWrapper<T> {
    
    private let key: String
    private let defaultValue: T
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
}

enum UserDefaultsKey: String, CaseIterable {
    case isAppFirstLaunch
    case verificationID
    case idToken
}

struct UserDefaultsManager {
    
    /// 앱 첫 실행시
    @UserDefaultsWrapper(key: UserDefaultsKey.isAppFirstLaunch.rawValue, defaultValue: true)
    static var isAppFirstLaunch: Bool
    
    /// 파이어베이스 인증 ID
    @UserDefaultsWrapper(key: UserDefaultsKey.verificationID.rawValue, defaultValue: "")
    static var verificationID: String
    
    /// idToken
    @UserDefaultsWrapper(key: UserDefaultsKey.idToken.rawValue, defaultValue: "")
    static var idToken: String
}
