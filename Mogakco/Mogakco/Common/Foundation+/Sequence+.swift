//
//  Sequence+.swift
//  Mogakco
//
//  Created by taekki on 2022/12/08.
//

import Foundation

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
