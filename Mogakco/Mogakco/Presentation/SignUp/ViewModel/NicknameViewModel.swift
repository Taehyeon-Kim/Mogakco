//
//  NicknameViewModel.swift
//  Mogakco
//
//  Created by taekki on 2022/11/13.
//

import Foundation

import RxCocoa
import RxSwift

final class NicknameViewModel {
    
    enum NicknameError: LocalizedError {
        case invalidLength
        
        var errorDescription: String? {
            switch self {
            case .invalidLength:
                return "닉네임은 1자 이상 10자 이내로 부탁드려요."
            }
        }
    }

    private var disposeBag = DisposeBag()
    private var nickname = BehaviorRelay(value: "")
    
    private var validator: Validator
    private var userManager: UserManager
    
    init(
        validator: Validator,
        userManager: UserManager
    ) {
        self.validator = validator
        self.userManager = userManager
    }
    
    struct Input {
        let changedText: Observable<String>     // 닉네임 텍스트 필드 텍스트
        let nextButtonDidTap: Observable<Void>
        let backButtonDidTap: Observable<Void>
    }
    
    struct Output {
        let isNextButtonEnabled: Driver<Bool>
        let isSucceed: Driver<Void>
        let errorOccured: Driver<NicknameError>
        let isBackButtonTapped: Driver<Void>
    }
}

extension NicknameViewModel: ViewModelType {
    
    func transform(input: Input) -> Output {
        
        let changedText = input.changedText
            .asDriver(onErrorJustReturn: "")
        
        changedText
            .drive(with: self) { owner, nick in owner.nickname.accept(nick) }
            .disposed(by: disposeBag)
        
        let isNextButtonEnabled = changedText
            .map(validator.isValid(nickname:))
        
        let isNextButtonSelected = input.nextButtonDidTap
            .asDriver(onErrorJustReturn: ())
        
        let isSucceed = isNextButtonSelected
            .withLatestFrom(isNextButtonEnabled) { $1 }
            .filter { $0 }
            .map { _ in () }
        
        isSucceed
            .drive(with: self) { owner, _ in
                owner.store(owner.nickname.value)
            }
            .disposed(by: disposeBag)
        
        let errorOccured = isNextButtonSelected
            .withLatestFrom(isNextButtonEnabled) { $1 }
            .filter { !$0 }
            .map { _ in NicknameError.invalidLength }
        
        return Output(
            isNextButtonEnabled: isNextButtonEnabled,
            isSucceed: isSucceed,
            errorOccured: errorOccured,
            isBackButtonTapped: input.backButtonDidTap.asDriver(onErrorJustReturn: ())
        )
    }
}

extension NicknameViewModel {
    
    func store(_ nickname: String) {
        userManager.store(nickname: nickname)
    }
}
