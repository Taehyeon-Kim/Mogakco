//
//  MGCError.swift
//  Mogakco
//
//  Created by taekki on 2022/11/15.
//

import Foundation

struct MGCError: LocalizedError {
    
    let code: String
    let message: String
}

extension MGCError {
    
    var errorDescription: String? { return message }
}
