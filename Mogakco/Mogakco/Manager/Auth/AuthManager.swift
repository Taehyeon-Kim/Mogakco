//
//  AuthManager.swift
//  Mogakco
//
//  Created by taekki on 2022/11/18.
//

import Foundation

import FirebaseAuth
import RxSwift

protocol AuthManager {
    func renewalToken() -> Single<String>
}

final class AuthManagerImpl: AuthManager {
    
    private let auth: Auth
    
    init(auth: Auth = Auth.auth()) {
        self.auth = auth
    }
    
    func renewalToken() -> Single<String> {
        
        return Single.create { [unowned self] observer in
            
            auth.currentUser?.getIDTokenForcingRefresh(true) { token, error in
                
                if let error = error {
                    observer(.failure(error))
                }
                
                if let token = token {
                    print("♻️ 토큰 갱신: \(token)")
                    UserDefaultsManager.idToken = token
                    observer(.success(token))
                }
            }
            
            return Disposables.create()
        }
    }
}
