//
//  SignUpRepositoryImpl.swift
//  Mogakco
//
//  Created by taekki on 2022/12/01.
//

import Foundation
import RxSwift

final class SignUpRepositoryImpl: SignUpRepository {
    
    private let provider: NetworkProvider
    
    init(provider: NetworkProvider) {
        self.provider = provider
    }
    
    func createUser(_ signUpAPI: SignUpAPI) -> Observable<SignUpAPI.Response> {
        return provider.execute(of: signUpAPI).asObservable()
    }
}
