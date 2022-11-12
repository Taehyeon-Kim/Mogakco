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

        let firebaseRepository = FirebaseAuthRepositoryImpl()
        let viewModel = PhoneEntryViewModel(firebaseRepository: firebaseRepository)
        let viewController = PhoneEntryViewController(viewModel: viewModel)
        window?.rootViewController = UINavigationController(rootViewController: viewController)
        window?.makeKeyAndVisible()
    }
}
