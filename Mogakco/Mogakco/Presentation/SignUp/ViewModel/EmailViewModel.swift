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
    private var email = ""
    
    var validator: Validator = ValidatorImpl()

    struct Input {
        let changedText: ControlProperty<String>
        let nextButtonTrigger: ControlEvent<Void>
    }
    
    struct Output {
        let isEnabled: Signal<Bool>
        let nextButtonTrigger: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        
        let isEnabled = input.changedText
            .asSignal(onErrorJustReturn: "")
            .map(validator.isValid(email:))
        
        return Output(
            isEnabled: isEnabled,
            nextButtonTrigger: input.nextButtonTrigger.asDriver()
        )
    }
}
