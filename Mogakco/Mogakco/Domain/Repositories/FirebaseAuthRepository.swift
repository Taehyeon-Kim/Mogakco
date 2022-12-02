//
//  FirebaseAuthRepository.swift
//  Mogakco
//
//  Created by taekki on 2022/11/12.
//

import Foundation
import RxSwift

protocol FirebaseAuthRepository {
    func fetchVerificationID(of phoneNumber: String) -> Single<String>
    func verify(for code: String) -> Single<String>
    func requestIDToken() -> Single<String>
}
