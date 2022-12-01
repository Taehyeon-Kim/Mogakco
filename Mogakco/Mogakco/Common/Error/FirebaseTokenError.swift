//
//  FirebaseTokenError.swift
//  Mogakco
//
//  Created by taekki on 2022/11/15.
//

import Foundation

enum FirebaseTokenError: Error {
    
    /// 최초 인증 전에는 none
    case none
    
    /// 만료: 만료 시 토큰 갱신 로직 수행
    case expired
}
