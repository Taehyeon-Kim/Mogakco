//
//  Tab.swift
//  Mogakco
//
//  Created by taekki on 2022/11/26.
//

import UIKit

enum Tab: Int, CaseIterable {
    case map
    case shop
    case friend
    case profile
}

extension Tab {
    
    var title: String {
        switch self {
        case .map:
            return "홈"
        case .shop:
            return "새싹샵"
        case .friend:
            return "새싹친구"
        case .profile:
            return "내정보"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .map:
            return .icnTabHomeInactive
        case .shop:
            return .icnTabShopInactive
        case .friend:
            return .icnTabFriendInactive
        case .profile:
            return .icnTabProfileInactive
        }
    }
    
    var selectedImage: UIImage? {
        switch self {
        case .map:
            return .icnTabHomeActive
        case .shop:
            return .icnTabShopActive
        case .friend:
            return .icnTabFriendActive
        case .profile:
            return .icnTabProfileActive
        }
    }
}

extension Tab {
    
    func asTabBarItem() -> UITabBarItem {
        return UITabBarItem(title: title, image: image, selectedImage: selectedImage)
    }
}
