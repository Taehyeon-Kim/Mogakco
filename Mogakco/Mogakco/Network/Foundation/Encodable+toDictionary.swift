//
//  Encodable+toDictionary.swift
//  Mogakco
//
//  Created by taekki on 2022/11/11.
//

import Foundation

extension Encodable {
    func toDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let jsonData = try JSONSerialization.jsonObject(with: data)
        return jsonData as? [String: Any]
    }
}
