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
        tabBar.layer.applyShadow(color: .MGC.black, alpha: 0.04, x: 0, y: -1, blur: 1)
    }
}

extension TabBarController {
    
    private func viewControllers(with tab: [Tab]) -> [UIViewController] {
        return tab.map { tab in
            let viewController: UIViewController
            
            switch tab {
            case .map:
                let networkProvider = NetworkProviderImpl()
                let locationManager = LocationManagerImpl()
                let viewModel = MapViewModel(
                    networkProvider: networkProvider,
                    locationManager: locationManager
                )
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
