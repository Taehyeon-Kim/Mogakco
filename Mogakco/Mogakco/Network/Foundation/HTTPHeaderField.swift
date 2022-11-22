//
//  HTTPHeaderField.swift
//  Mogakco
//
//  Created by taekki on 2022/11/19.
//

import Foundation

enum HTTPHeaderField: String {
    case contentType = "Content-Type"
    case idToken = "idtoken"
}

enum ContentType: String {
    case urlEncoded = "application/x-www-form-urlencoded"
    case json = "application/json"
    case multipart = "multipart/form-data"
}

extension HTTPHeaderField {
    
    static var `default`: [String: String] {
        var dict: [String: String] = [:]
        dict[HTTPHeaderField.contentType.rawValue] = ContentType.json.rawValue
        dict[HTTPHeaderField.idToken.rawValue] = UserDefaultsManager.idToken
        return dict
    }
}
