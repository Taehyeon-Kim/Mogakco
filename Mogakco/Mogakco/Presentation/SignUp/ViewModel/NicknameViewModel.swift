//
//  NicknameViewModel.swift
//  Mogakco
//
//  Created by taekki on 2022/11/13.
//

import Foundation

import RxCocoa
import RxSwift

final class NicknameViewModel: ViewModelType {

    private var disposeBag = DisposeBag()

    struct Input {
        let changedText: ControlProperty<String>
        let nextButtonTrigger: ControlEvent<Void>
    }
    
    struct Output {
        let nickname: Driver<String>
        let isEnabled: Signal<Bool>
        let nextButtonTrigger: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        
        let nickname = input.changedText
            .asDriver()
            .scan("") { prev, next in
                return (11...).contains(next.count) ? prev : next
            }
        
        let isEnabled = input.changedText
            .asSignal(onErrorJustReturn: "")
            .map(isValid)
        
        return Output(
            nickname: nickname,
            isEnabled: isEnabled,
            nextButtonTrigger: input.nextButtonTrigger.asDriver()
        )
    }
}

extension NicknameViewModel {
    
    private func isValid(text: String) -> Bool {
        return (1...10).contains(text.count)
    }
}
