//
//  TabBarController.swift
//  Mogakco
//
//  Created by taekki on 2022/11/26.
//

import UIKit

final class TabBarController: BaseTabBarController {
    
    private let tabs: [Tab] = Tab.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
    }
    
    private func setTabBar() {
        setViewControllers(viewControllers(with: tabs), animated: true)
    }
}

extension TabBarController {
    
    private func viewControllers(with tab: [Tab]) -> [UIViewController] {
        return tab.map { tab in
            let viewController: UIViewController
            
            switch tab {
            case .map:
                let viewModel = MapViewModel()
                let rootViewController = MapViewController(viewModel: viewModel)
                viewController = UINavigationController(rootViewController: rootViewController)
                
            case .shop:
                let rootViewController = ShopViewController()
                viewController = UINavigationController(rootViewController: rootViewController)
                
            case .friend:
                let rootViewController = FriendViewController()
                viewController = UINavigationController(rootViewController: rootViewController)
                
            case .profile:
                let viewModel = MyProfileViewModel()
                let rootViewController = MyProfileViewController(viewModel: viewModel)
                viewController = UINavigationController(rootViewController: rootViewController)
            }
            
            viewController.tabBarItem = tab.asTabBarItem()
            return viewController
        }
    }
}
