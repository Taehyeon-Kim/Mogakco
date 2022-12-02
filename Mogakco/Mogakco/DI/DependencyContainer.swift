//
//  DependencyContainer.swift
//  Mogakco
//
//  Created by taekki on 2022/12/02.
//

import Foundation

class DependencyContainer {
    private lazy var networkProvider = NetworkProviderImpl()
    private lazy var userManager = UserManagerImpl.shared
}

extension DependencyContainer: SignUpViewControllerFactory {
    
    func makeNicknameViewController() -> NicknameViewController {
        let viewModel = NicknameViewModel(userManager: userManager)
        return NicknameViewController(viewModel: viewModel)
    }
    
    func makeBirthViewController() -> BirthViewController {
        let viewModel = BirthViewModel(userManager: userManager)
        return BirthViewController(viewModel: viewModel)
    }
    
    func makeEmailViewController() -> EmailViewController {
        let viewModel = EmailViewModel(userManager: userManager)
        return EmailViewController(viewModel: viewModel)
    }
    
    func makeGenderViewController() -> GenderViewController {
        let viewModel = GenderViewModel(userManager: userManager)
        return GenderViewController(viewModel: viewModel)
    }
}
