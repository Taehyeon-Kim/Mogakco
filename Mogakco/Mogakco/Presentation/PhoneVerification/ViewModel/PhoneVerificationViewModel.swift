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
    
    var disposeBag = DisposeBag()

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
                return next.count > maxNumber ? prev : next
            }
        
        let isEnabled = verificationCode
            .map { $0.count == maxNumber }
            .asDriver(onErrorJustReturn: false)
            
        return Output(
            verificationCode: verificationCode.asDriver(onErrorJustReturn: ""),
            isEnabled: isEnabled
        )
    }
}
