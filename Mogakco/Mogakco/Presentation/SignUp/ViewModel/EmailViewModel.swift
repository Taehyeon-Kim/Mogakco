//
//  EmailViewModel.swift
//  Mogakco
//
//  Created by taekki on 2022/12/01.
//

import Foundation

import RxCocoa
import RxSwift

final class EmailViewModel: ViewModelType {

    private var disposeBag = DisposeBag()
    private var validator: Validator
    private var userManager: UserManager
    
    private var email = BehaviorRelay(value: "")
    
    init(
        validator: Validator,
        userManager: UserManager
    ) {
        self.validator = validator
        self.userManager = userManager
    }

    struct Input {
        let emailValue: Observable<String>
        let nextButtonTrigger: Observable<Void>
        let backButtonDidTap: Observable<Void>
    }
    
    struct Output {
        let isEnabled: Driver<Bool>
        let nextButtonTrigger: Driver<Void>
        let success: Driver<Void>
        let error: Driver<String>
        let isBackButtonTapped: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        
        let isEnabled = input.emailValue
            .withUnretained(self)
            .map { owner, email -> Bool in
                let isEnabled = owner.validator.isValid(email: email)
                
                if isEnabled {
                    owner.email.accept(email)
                }
                
                return isEnabled
            }
            .asDriver(onErrorJustReturn: false)

        let success = PublishRelay<Void>()
        let error = PublishRelay<String>()
        
        input.nextButtonTrigger
            .withLatestFrom(isEnabled)
            .asDriver(onErrorJustReturn: false)
            .drive(with: self) { owner, isEnabled in
                if isEnabled {
                    owner.userManager.store(email: owner.email.value)
                    success.accept(())
                } else {
                    error.accept("이메일 형식이 올바르지 않습니다.")
                }
            }
            .disposed(by: disposeBag)
            
        return Output(
            isEnabled: isEnabled,
            nextButtonTrigger: input.nextButtonTrigger.asDriver(onErrorJustReturn: ()),
            success: success.asDriver(onErrorJustReturn: ()),
            error: error.asDriver(onErrorJustReturn: ""),
            isBackButtonTapped: input.backButtonDidTap.asDriver(onErrorJustReturn: ())
        )
    }
}
