//
//  EmptyResponse.swift
//  Mogakco
//
//  Created by taekki on 2022/11/11.
//

import Foundation

struct EmptyResponse: Decodable {}

extension Data {
    static let empty = "{}".data(using: .utf8)!
}
