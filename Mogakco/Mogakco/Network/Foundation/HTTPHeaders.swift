//
//  HTTPHeaders.swift
//  Mogakco
//
//  Created by taekki on 2022/11/13.
//

import Foundation

enum HTTPHeaders {
    
    static let headerWithIDToken: [String: String] = [
        "idtoken": UserDefaultsManager.idToken
    ]
}
