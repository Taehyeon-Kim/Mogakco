//
//  FirebaseAuthRepositoryImpl.swift
//  Mogakco
//
//  Created by taekki on 2022/11/12.
//

import Foundation

import Firebase
import FirebaseAuth
import RxCocoa
import RxSwift

enum FirebaseAuthRepositoryError: Error {
    case verifyPhoneError(Error)
    case firebaseAuthError(Error)
    case noVerificationID
    case noToken
}

final class FirebaseAuthRepositoryImpl: FirebaseAuthRepository {
    
    typealias Error = FirebaseAuthRepositoryError
    
    func fetchVerificationID(of phoneNumber: String) -> Single<String> {
        
        let phoneNumber = "+82" + phoneNumber
        
        return Single.create { single in
            PhoneAuthProvider.provider()
                .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
                    
                    if let error = error {
                        single(.failure(Error.verifyPhoneError(error)))
                    }
                    
                    if let verificationID {
                        UserDefaultsManager.verificationID = verificationID // 토큰 저장
                        single(.success(verificationID))
                    } else {
                        single(.failure(Error.noVerificationID))
                    }
                }
            
            return Disposables.create()
        }
    }
    
    func verify(for code: String) -> Single<String> {
        
        let verificationID = UserDefaultsManager.verificationID
        let verificationCode = code
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)
        
        return Single.create { single in
            Auth.auth().signIn(with: credential) { result, error in
                
                if let error = error {
                    single(.failure(Error.firebaseAuthError(error)))
                }
                
                result?.user.getIDToken { token, error in
                    
                    if let error = error {
                        single(.failure(error))
                    }
                    
                    if let token = token {
                        single(.success(token))
                    } else {
                        single(.failure(Error.noToken))
                    }
                }
            }
            
            return Disposables.create()
        }
    }
    
    func requestIDToken() -> Single<String> {
        let currentUser = Auth.auth().currentUser
        
        return Single.create { single in
            currentUser?.getIDTokenForcingRefresh(true) { token, error in
                
                if let error = error {
                    single(.failure(error))
                }
                
                if let token = token {
                    single(.success(token))
                } else {
                    single(.failure(Error.noToken))
                }
            }
            
            return Disposables.create()
        }
    }
}
