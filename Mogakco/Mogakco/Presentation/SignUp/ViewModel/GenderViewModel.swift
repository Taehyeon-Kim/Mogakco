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
    private var gender = 0
    
    var validator: Validator = ValidatorImpl()
    var userManager: UserManager
    
    init(userManager: UserManager) {
        self.userManager = userManager
        print("🐙 GenderViewModel 데이터 === \(userManager.userInfo)")
    }

    struct Input {

    }
    
    struct Output {

    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        return output
    }
}

extension GenderViewModel {
    
    func storeGender() {
        userManager.store(gender: gender)
    }
}
