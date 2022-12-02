//
//  RealmConvertibleType.swift
//  Mogakco
//
//  Created by taekki on 2022/12/03.
//

import Foundation

protocol RealmConvertibleType {
    associatedtype RealmType: DomainConvertibleType
    
    func asRealm() -> RealmType
}
