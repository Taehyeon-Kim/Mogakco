//
//  Validator.swift
//  Mogakco
//
//  Created by taekki on 2022/12/01.
//

import Foundation

protocol Validator {
    func isValid(email: String) -> Bool
}

final class ValidatorImpl: Validator {
    
    func isValid(email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: email)
    }
}
