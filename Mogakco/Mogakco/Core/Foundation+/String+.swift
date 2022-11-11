//
//  String+.swift
//  Mogakco
//
//  Created by taekki on 2022/11/12.
//

import Foundation

extension String {
    
    func removeHyphen() -> String {
        return self.replacingOccurrences(of: "-", with: "")
    }
    
    func phoneNumberFormat() -> String {
        var str = removeHyphen()
        let strCount = str.count
        let startIndex = str.startIndex

        switch strCount {
        case 4...6:
            let index1 = str.index(startIndex, offsetBy: 3)
            str.insert("-", at: index1)
            return str
        case 7...9, 10:
            let index1 = str.index(startIndex, offsetBy: 3)
            let index2 = str.index(startIndex, offsetBy: 7)
            str.insert("-", at: index1)
            str.insert("-", at: index2)
            return str
        case 11...:
            let index1 = str.index(startIndex, offsetBy: 3)
            let index2 = str.index(startIndex, offsetBy: 8)
            str.insert("-", at: index1)
            str.insert("-", at: index2)
            return str
        default:
            return str
        }
    }
}
