//
//  SceneDelegate.swift
//  Mogakco
//
//  Created by taekki on 2022/11/07.
//

import UIKit
import RxSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let disposeBag = DisposeBag()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        //
        // let repository = QueueRepositoryImpl()
        // let useCase = SearchStudyUseCaseImpl(queueRepository: repository)
        // let parameter = SearchAPI(lat: 37.517819364682694, long: 126.88647317074734)
        // let viewModel = KeywordViewModel(searchParameter: parameter, searchStudyUseCase: useCase)
        // let viewController = KeywordViewController(viewModel: viewModel)
        
        let validator = ValidatorImpl()
        let userManager = UserManagerImpl.shared
        let viewModel = BirthViewModel(validator: validator, userManager: userManager)
        window?.rootViewController = BirthViewController(viewModel: viewModel)
        window?.makeKeyAndVisible()
    }
}
