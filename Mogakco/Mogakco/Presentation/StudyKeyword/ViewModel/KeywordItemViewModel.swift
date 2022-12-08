//
//  KeywordItemViewModel.swift
//  Mogakco
//
//  Created by taekki on 2022/12/08.
//

import Foundation

struct KeywordItemViewModel: Equatable, Hashable {
    
    enum KeywordType {
        case recommended
        case arounded
        case wanted
    }
    
    let contents: String
    let keywordType: KeywordType
}
