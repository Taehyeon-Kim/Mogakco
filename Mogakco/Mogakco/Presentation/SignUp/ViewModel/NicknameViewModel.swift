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
    private var nickname = ""
    
    var userManager: UserManager
    
    init(userManager: UserManager) {
        self.userManager = userManager
        print("🐙 NicknameViewModel 데이터 === \(userManager.userInfo)")
    }

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
            .scan("") { [weak self] prev, next in
                let nickname = (11...).contains(next.count) ? prev : next
                self?.nickname = nickname
                return nickname
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
    
    private func isValid(nickname: String) -> Bool {
        return (1...10).contains(nickname.count)
    }
    
    func saveNickname() {
        // UserDefaultsManager.nickname = nickname
        print("어떤 값이 저장되죠? \(nickname)")
        userManager.store(nickname: nickname)
    }
}
