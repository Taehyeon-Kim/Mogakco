//
//  BaseTabBarController.swift
//  Mogakco
//
//  Created by taekki on 2022/11/26.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setTabBarAppearance()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BaseTabBarController {
    
    private func setTabBarAppearance() {
        self.tabBar.backgroundColor = .MGC.white
        self.tabBar.tintColor = .MGC.green
        
        clearShadow()
    }
    
    private func clearShadow() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.white
    }
}
