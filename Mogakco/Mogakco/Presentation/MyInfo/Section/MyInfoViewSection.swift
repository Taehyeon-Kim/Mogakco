//
//  MyInfoViewSection.swift
//  Mogakco
//
//  Created by taekki on 2022/11/21.
//

import UIKit
import RxDataSources

enum MyInfoViewSection {
    case profile([MyInfoViewSectionItem])
    case option([MyInfoViewSectionItem])
}

extension MyInfoViewSection: SectionModelType {
    var items: [MyInfoViewSectionItem] {
        switch self {
        case let .profile(items):   return items
        case let .option(items):    return items
        }
    }
    
    init(original: MyInfoViewSection, items: [MyInfoViewSectionItem]) {
        switch original {
        case .profile:  self = .profile(items)
        case .option:   self = .option(items)
        }
    }
}

enum MyInfoViewSectionItem {
    case profile(MyInfoItemCellViewModel)
    case notice(MyInfoItemCellViewModel)
    case faq(MyInfoItemCellViewModel)
    case qna(MyInfoItemCellViewModel)
    case settingAlarm(MyInfoItemCellViewModel)
    case permit(MyInfoItemCellViewModel)
}
