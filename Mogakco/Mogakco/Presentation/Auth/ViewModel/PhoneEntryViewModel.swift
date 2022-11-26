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
    
    private let firebaseRepository: FirebaseAuthRepository
    
    private var disposeBag = DisposeBag()
    private var phoneEntry = ""
    private let isSucceed = PublishSubject<String>()
    private let isError = PublishSubject<String>()
    
    init(
        firebaseRepository: FirebaseAuthRepository
    ) {
        self.firebaseRepository = firebaseRepository
    }

    struct Input {
        let phoneEntryText: ControlProperty<String>
        let buttonTrigger: ControlEvent<Void>
    }
    
    struct Output {
        let phoneEntryText: Driver<String>
        let isEnabled: Signal<Bool>
        let isSucceedVerification: Driver<String>
        let isErrorVerification: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        let maxNumber = 13
        let phoneNumberRange = (11...maxNumber)

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
            .withUnretained(self)
            .map { `self`, _ in self.fetchVerificationID() }
            .subscribe()
            .disposed(by: disposeBag)

        return Output(
            phoneEntryText: phoneEntryText.asDriver(onErrorJustReturn: ""),
            isEnabled: isEnabled,
            isSucceedVerification: isSucceed.asDriver(onErrorJustReturn: ""),
            isErrorVerification: isError.asDriver(onErrorJustReturn: "")
        )
    }
}

extension PhoneEntryViewModel {
    
    func isValid(for phoneNumber: String) -> Bool {
        let pattern = "^01([0-9])([0-9]{3,4})([0-9]{4})$"
        let regex = NSPredicate(format: "SELF MATCHES %@", pattern)
        return regex.evaluate(with: phoneNumber.removeHyphen())
    }
    
    func fetchVerificationID() {
        let phoneNumber = phoneEntry.removeHyphen()
        firebaseRepository.fetchVerificationID(of: phoneNumber)
            .subscribe { [weak self] id in
                print("🐙 :: 성공 \(id)")
                self?.isSucceed.onNext(id)
            } onFailure: { [weak self] error in
                print("🐙 :: 실패 \(error)")
                self?.isError.onNext(error.localizedDescription)
            }
            .disposed(by: disposeBag)
    }
}
