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
    
    private lazy var birth = BehaviorRelay(value: userManager.userInfo.birth)
    
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
        let birth: Driver<Date>
    }
    
    func transform(input: Input) -> Output {
        let year = PublishRelay<String>()
        let month = PublishRelay<String>()
        let day = PublishRelay<String>()
        
        let birth = birth
            .withUnretained(self)
            .map { owner, dateString -> Date in
                let date = owner.convertToDate(from: dateString) ?? Date()
                let dateComponents = owner.calendar.dateComponents([.year, .month, .day], from: date)
                year.accept(String(dateComponents.year ?? 0))
                month.accept(String(dateComponents.month ?? 0))
                day.accept(String(dateComponents.day ?? 0))
                return date
            }
            .asDriver(onErrorJustReturn: Date())
        
        input.changedValue
            .skip(1)
            .bind(with: self) { owner, date in
                let dateString = owner.convertToString(from: date)
                owner.birth.accept(dateString)
            }
            .disposed(by: disposeBag)

        let isEnabled = input.changedValue
            .withUnretained(self)
            .map { owner, date -> Bool in
                let birth = owner.birth.value
                let date = birth.isEmpty ? date : owner.convertToDate(from: birth) ?? Date()
                let isEnabled = owner.validator.isValid(age: date)
                let dateString = owner.convertToString(from: date)
                owner.birth.accept(dateString)
                owner.storeBirth(owner.birth.value)
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
            year: year.asSignal(),
            month: month.asSignal(),
            day: day.asSignal(),
            isEnabled: isEnabled,
            doneButtonTrigger: input.doneButtonTrigger.asDriver(onErrorJustReturn: ()),
            datePickerButtonTrigger: input.datePickerButtonTrigger.asDriver(onErrorJustReturn: ()),
            nextButtonTrigger: input.nextButtonTrigger.asDriver(onErrorJustReturn: ()),
            success: success.asDriver(onErrorJustReturn: ()),
            error: error.asDriver(onErrorJustReturn: ""),
            isBackButtonTapped: input.backButtonDidTap.asDriver(onErrorJustReturn: ()),
            birth: birth
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
    
    private func convertToDate(from dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSS'Z"
        return dateFormatter.date(from: dateString)
    }
}
