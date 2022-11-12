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
    
    var repository: FirebaseAuthRepository!
    
    var disposeBag = DisposeBag()
    
    private var verificationCode = ""

    struct Input {
        let verificationCode: ControlProperty<String>
        let resendButtonTrigger: ControlEvent<Void>
        let verifyButtonTrigger: ControlEvent<Void>
    }
    
    struct Output {
        let verificationCode: Driver<String>
        let isEnabled: Driver<Bool>
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
            .flatMap { `self`, _ in
                self.repository.verify(for: self.verificationCode)  // Single로 처리해야할듯
            }
            .subscribe()
            .disposed(by: disposeBag)
            
        return Output(
            verificationCode: verificationCode.asDriver(onErrorJustReturn: ""),
            isEnabled: isEnabled
        )
    }
}
