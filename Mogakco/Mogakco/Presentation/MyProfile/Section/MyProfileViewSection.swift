//
//  MyProfileViewSection.swift
//  Mogakco
//
//  Created by taekki on 2022/11/21.
//

import UIKit
import RxDataSources

enum MyProfileViewSection {
    case profile([MyInfoViewSectionItem])
    case option([MyInfoViewSectionItem])
}

extension MyProfileViewSection: SectionModelType {
    var items: [MyInfoViewSectionItem] {
        switch self {
        case let .profile(items):   return items
        case let .option(items):    return items
        }
    }
    
    init(original: MyProfileViewSection, items: [MyInfoViewSectionItem]) {
        switch original {
        case .profile:  self = .profile(items)
        case .option:   self = .option(items)
        }
    }
}

enum MyInfoViewSectionItem {
    case profile(MyProfileItemCellViewModel)
    case notice(MyProfileItemCellViewModel)
    case faq(MyProfileItemCellViewModel)
    case qna(MyProfileItemCellViewModel)
    case settingAlarm(MyProfileItemCellViewModel)
    case permit(MyProfileItemCellViewModel)
}
