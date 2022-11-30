//
//  ChatSection.swift
//  Mogakco
//
//  Created by taekki on 2022/11/30.
//

import Foundation
import RxDataSources

struct ChatSection {
    var header: ChatSectionHeader?
    var footer: String?
    var items: [Item]
}

struct ChatSectionHeader {
    let date: String
    let user: String
}

struct ChatSectionItem {
    let chat: String
    let time: String
}

extension ChatSection: SectionModelType {
    typealias Item = ChatSectionItem
    
    init(original: ChatSection, items: [Item]) {
        self = original
        self.items = items
    }
}
