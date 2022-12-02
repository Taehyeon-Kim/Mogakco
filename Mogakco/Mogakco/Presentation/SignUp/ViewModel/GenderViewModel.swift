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
