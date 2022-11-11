//
//  PhoneEntryViewModel.swift
//  Mogakco
//
//  Created by taekki on 2022/11/10.
//

import Foundation

import RxCocoa
import RxSwift

final class PhoneEntryViewModel: ViewModelType {
    
    private var phoneEntry = ""
    var disposeBag = DisposeBag()

    struct Input {
        let phoneEntryText: ControlProperty<String>
        let buttonTrigger: ControlEvent<Void>
    }
    
    struct Output {
        let phoneEntryText: Driver<String>
        let isEnabled: Signal<Bool>
    }
    
    func transform(input: Input) -> Output {
        let maxNumber = 13
        let phoneNumberRange = (11...maxNumber)
        
        /// scan: 글자수 제한
        let phoneEntryText = input.phoneEntryText
            .map { $0.phoneNumberFormat() }
            .scan("") { prev, next in
                self.phoneEntry = next.count > maxNumber ? prev : next
                return self.phoneEntry
            }

        let isEnabled = input.phoneEntryText
            .withUnretained(self)
            .map { `self`, phoneNumber in
                phoneNumberRange.contains(phoneNumber.count) && self.isValid(for: phoneNumber)
            }
            .asSignal(onErrorJustReturn: false)
        
        input.buttonTrigger
            .subscribe { _ in
                // print(self.phoneEntry.removeHyphen())
                // 전화번호 가지고 인증코드 받는 로직 실행
            }
            .disposed(by: disposeBag)

        return Output(
            phoneEntryText: phoneEntryText.asDriver(onErrorJustReturn: ""),
            isEnabled: isEnabled
        )
    }
}

extension PhoneEntryViewModel {
    
    func isValid(for phoneNumber: String) -> Bool {
        let pattern = "^01([0-9])([0-9]{3,4})([0-9]{4})$"
        let regex = NSPredicate(format: "SELF MATCHES %@", pattern)
        return regex.evaluate(with: phoneNumber.removeHyphen())
    }
}
