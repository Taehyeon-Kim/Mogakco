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
    private lazy var validator = ValidatorImpl()
}

extension DependencyContainer: SignUpViewControllerFactory {
    
    func makeNicknameViewController() -> NicknameViewController {
        let viewModel = NicknameViewModel(validator: validator, userManager: userManager)
        return NicknameViewController(viewModel: viewModel)
    }
    
    func makeBirthViewController() -> BirthViewController {
        let viewModel = BirthViewModel(validator: validator, userManager: userManager)
        return BirthViewController(viewModel: viewModel)
    }
    
    func makeEmailViewController() -> EmailViewController {
        let viewModel = EmailViewModel(validator: validator, userManager: userManager)
        return EmailViewController(viewModel: viewModel)
    }
    
    func makeGenderViewController() -> GenderViewController {
        let viewModel = GenderViewModel(validator: validator, userManager: userManager, networkProvider: networkProvider)
        return GenderViewController(viewModel: viewModel)
    }
}
