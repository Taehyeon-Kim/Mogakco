//
//  Validator.swift
//  Mogakco
//
//  Created by taekki on 2022/12/01.
//

import Foundation

protocol Validator {
    func isValid(nickname: String) -> Bool
    func isValid(email: String) -> Bool
    func isValid(age: Date) -> Bool
}

final class ValidatorImpl: Validator {
    
    lazy var dateFormatter = DateFormatter().then {
        $0.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSS'Z"
    }
    
    func isValid(nickname: String) -> Bool {
        return (1...10).contains(nickname.count)
    }
    
    func isValid(email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: email)
    }
    
    func isValid(age: Date) -> Bool {
        let calendar = Calendar.current
        let today = Date()
        let ageLimit = 17
        
        let offset = calendar.dateComponents([.year, .month, .day], from: age, to: today)
        
        guard let year = offset.year else { return false }
        return year >= ageLimit
    }
}
