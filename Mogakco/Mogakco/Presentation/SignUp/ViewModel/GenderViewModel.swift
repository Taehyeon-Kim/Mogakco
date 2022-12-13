//
//  GenderViewModel.swift
//  Mogakco
//
//  Created by taekki on 2022/12/02.
//

import Foundation

import RxCocoa
import RxSwift

final class GenderViewModel: ViewModelType {

    private var disposeBag = DisposeBag()
    
    private var validator: Validator
    private var userManager: UserManager
    private var networkProvider: NetworkProvider
    
    init(
        validator: Validator,
        userManager: UserManager,
        networkProvider: NetworkProvider
    ) {
        self.validator = validator
        self.userManager = userManager
        self.networkProvider = networkProvider
    }

    struct Input {
        let selectedGender: Observable<Int>
        let nextButtonDidTap: Observable<Void>
        let backButtonDidTap: Observable<Void>
    }
    
    struct Output {
        let isEnabled: Driver<Bool>
        let success: Driver<Void>
        let error: Driver<String>
        let isBackButtonTapped: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        
        let isEnabled = input.selectedGender
            .map { _ in true }
            .asDriver(onErrorJustReturn: false)
        
        let success = PublishRelay<Void>()
        let error = PublishRelay<String>()
        
        input.selectedGender
            .map(userManager.store(gender:))
            .asDriver(onErrorJustReturn: ())
            .drive()
            .disposed(by: disposeBag)
        
        input.nextButtonDidTap
            .withLatestFrom(isEnabled)
            .subscribe(with: self) { owner, isEnabled in
                if isEnabled {
                    success.accept(())
                } else {
                    error.accept("성별을 선택해주세요")
                }
            }
            .disposed(by: disposeBag)
        
        return Output(
            isEnabled: isEnabled,
            success: success.asDriver(onErrorJustReturn: ()),
            error: error.asDriver(onErrorJustReturn: ""),
            isBackButtonTapped: input.backButtonDidTap.asDriver(onErrorJustReturn: ())
        )
    }
}
