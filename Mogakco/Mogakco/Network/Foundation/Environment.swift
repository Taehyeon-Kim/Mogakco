//
//  Environment.swift
//  Mogakco
//
//  Created by taekki on 2022/11/11.
//

import Foundation

struct Env {
    static var baseURL: String {
        #if DEBUG
        return "http://api.sesac.co.kr:1210"
        #else
        return ""
        #endif
    }
    
    static let apiVersion = "/v1"
}
