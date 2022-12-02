//
//  SignUpRepository.swift
//  Mogakco
//
//  Created by taekki on 2022/12/01.
//

import Foundation
import RxSwift

protocol SignUpRepository {
    func createUser(_ signUpAPI: SignUpAPI) -> Observable<SignUpAPI.Response>
}
