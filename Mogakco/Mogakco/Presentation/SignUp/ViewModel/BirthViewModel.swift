//
//  BirthViewModel.swift
//  Mogakco
//
//  Created by taekki on 2022/12/02.
//

import Foundation

import RxCocoa
import RxSwift

final class BirthViewModel: ViewModelType {

    private var disposeBag = DisposeBag()
    
    private lazy var calendar = Calendar.current
    private var validator: Validator
    private var userManager: UserManager
    
    private var birth = BehaviorRelay(value: "")
    
    init(
        validator: Validator,
        userManager: UserManager
    ) {
        self.validator = validator
        self.userManager = userManager
    }
    
    struct Input {
        let changedValue: Observable<Date>
        let doneButtonTrigger: Observable<Void>
        let datePickerButtonTrigger: Observable<Void>
        let nextButtonTrigger: Observable<Void>
        let backButtonDidTap: Observable<Void>
    }
    
    struct Output {
        let year: Signal<String>
        let month: Signal<String>
        let day: Signal<String>
        let isEnabled: Driver<Bool>
        let doneButtonTrigger: Driver<Void>
        let datePickerButtonTrigger: Driver<Void>
        let nextButtonTrigger: Driver<Void>
        let success: Driver<Void>
        let error: Driver<String>
        let isBackButtonTapped: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        let year = input.changedValue
            .skip(1)
            .withUnretained(self)
            .map { owner, date in
                let date = owner.calendar.dateComponents([.year], from: date)
                return String(date.year ?? 0)
            }
            .asSignal(onErrorJustReturn: "")
        
        let month = input.changedValue
            .skip(1)
            .withUnretained(self)
            .map { owner, date in
                let date = owner.calendar.dateComponents([.month], from: date)
                return String(date.month ?? 0)
            }
            .asSignal(onErrorJustReturn: "")
        
        let day = input.changedValue
            .skip(1)
            .withUnretained(self)
            .map { owner, date in
                let date = owner.calendar.dateComponents([.day], from: date)
                return String(date.day ?? 0)
            }
            .asSignal(onErrorJustReturn: "")
        
        let isEnabled = input.changedValue
            .withUnretained(self)
            .map { owner, date -> Bool in
                let isEnabled = owner.validator.isValid(age: date)
                
                if isEnabled {
                    let dateString = owner.convertToString(from: date)
                    owner.birth.accept(dateString)
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
                    owner.storeBirth(owner.birth.value)
                    success.accept(())
                } else {
                    error.accept("새싹스터디는 만 17세 이상만 사용할 수 있습니다.")
                }
            }
            .disposed(by: disposeBag)
        
        return Output(
            year: year,
            month: month,
            day: day,
            isEnabled: isEnabled,
            doneButtonTrigger: input.doneButtonTrigger.asDriver(onErrorJustReturn: ()),
            datePickerButtonTrigger: input.datePickerButtonTrigger.asDriver(onErrorJustReturn: ()),
            nextButtonTrigger: input.nextButtonTrigger.asDriver(onErrorJustReturn: ()),
            success: success.asDriver(onErrorJustReturn: ()),
            error: error.asDriver(onErrorJustReturn: ""),
            isBackButtonTapped: input.backButtonDidTap.asDriver(onErrorJustReturn: ())
        )
    }
}

extension BirthViewModel {
    
    private func storeBirth(_ birth: String) {
        userManager.store(birth: birth)
    }
    
    private func convertToString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSS'Z"
        return dateFormatter.string(from: date)
    }
}
