//
//  HTTPHeaders.swift
//  Mogakco
//
//  Created by taekki on 2022/11/13.
//

import Foundation

enum HTTPHeader {
    
    static let headerWithIDToken: [String: String] = [
        "Content-Type": "Application/json",
        "idtoken": UserDefaultsManager.idToken
    ]
}
