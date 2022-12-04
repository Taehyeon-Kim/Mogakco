//
//  SceneDelegate.swift
//  Mogakco
//
//  Created by taekki on 2022/11/07.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        // let container = DependencyContainer()
        // let viewController = container.makeNicknameViewController()
        
        let tabBarController = TabBarController()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}
