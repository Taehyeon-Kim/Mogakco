//
//  PhoneVerificationViewModel.swift
//  Mogakco
//
//  Created by taekki on 2022/11/10.
//

import Foundation

import RxCocoa
import RxSwift

final class PhoneVerificationViewModel: ViewModelType {
    
    private var firebaseRepository: FirebaseAuthRepository
    
    var disposeBag = DisposeBag()
    private var verificationCode = ""
    private let isSucceed = PublishSubject<String>()
    private let isError = PublishSubject<String>()
    
    init(
        firebaseRepository: FirebaseAuthRepository
    ) {
        self.firebaseRepository = firebaseRepository
    }

    struct Input {
        let verificationCode: ControlProperty<String>
        let resendButtonTrigger: ControlEvent<Void>
        let verifyButtonTrigger: ControlEvent<Void>
    }
    
    struct Output {
        let verificationCode: Driver<String>
        let isEnabled: Driver<Bool>
        let isSucceedVerification: Driver<String>
        let isErrorVerification: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        let maxNumber = 6
        
        let verificationCode = input.verificationCode
            .scan("") { prev, next in
                self.verificationCode = next.count > maxNumber ? prev : next
                return self.verificationCode
            }
        
        let isEnabled = verificationCode
            .map { $0.count == maxNumber }
            .asDriver(onErrorJustReturn: false)
        
        input.verifyButtonTrigger
            .withUnretained(self)
            .map { `self`, _ in self.verifyUser() }
            .subscribe()
            .disposed(by: disposeBag)
            
        return Output(
            verificationCode: verificationCode.asDriver(onErrorJustReturn: ""),
            isEnabled: isEnabled,
            isSucceedVerification: isSucceed.asDriver(onErrorJustReturn: ""),
            isErrorVerification: isError.asDriver(onErrorJustReturn: "")
        )
    }
}

extension PhoneVerificationViewModel {
    
    func verifyUser() {
        firebaseRepository.verify(for: verificationCode)
            .subscribe { [weak self] idToken in
                print("🐙 :: 성공 \(idToken)")
                self?.isSucceed.onNext(idToken)
            } onFailure: { [weak self] error in
                self?.isError.onNext(error.localizedDescription)
            }
            .disposed(by: disposeBag)
    }
}
