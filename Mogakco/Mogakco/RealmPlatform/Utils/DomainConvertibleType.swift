//
//  DomainConvertibleType.swift
//  Mogakco
//
//  Created by taekki on 2022/12/02.
//

import Foundation

protocol DomainConvertibleType {
    associatedtype DomainType
    
    func asDomain() -> DomainType
}
