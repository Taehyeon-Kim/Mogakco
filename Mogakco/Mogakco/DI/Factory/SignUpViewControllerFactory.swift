//
//  SignUpViewControllerFactory.swift
//  Mogakco
//
//  Created by taekki on 2022/12/02.
//

import Foundation

protocol SignUpViewControllerFactory {
    func makeNicknameViewController() -> NicknameViewController
    func makeBirthViewController() -> BirthViewController
    func makeEmailViewController() -> EmailViewController
    func makeGenderViewController() -> GenderViewController
}
