//
//  SignUpUseCase.swift
//  Mogakco
//
//  Created by taekki on 2022/12/01.
//

import Foundation
import RxSwift

protocol SignUpUseCase {
    func execute(_ signUpAPI: SignUpAPI) -> Observable<SignUpAPI.Response>
}

final class SignUpUseCaseImpl: SignUpUseCase {
    
    let signUpRepository: SignUpRepository
    
    init(signUpRepository: SignUpRepository) {
        self.signUpRepository = signUpRepository
    }
    
    func execute(_ signUpAPI: SignUpAPI) -> Observable<SignUpAPI.Response> {
        return signUpRepository.createUser(signUpAPI)
    }
}
