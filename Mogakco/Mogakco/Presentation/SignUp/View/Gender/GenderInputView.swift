//
//  GenderInputView.swift
//  Mogakco
//
//  Created by taekki on 2022/11/11.
//

import UIKit

import SnapKit
import Then
import RxCocoa
import RxSwift

final class GenderInputView: BaseView {
    
    enum Gender: Int {
        case man = 0
        case woman = 1
    }
    
    private lazy var containerHStackView = UIStackView(arrangedSubviews: [manButton, womanButton])
    private let manButton = UIButton()
    private let womanButton = UIButton()
    
    private var disposeBag = DisposeBag()
    var selectedGender = PublishRelay<Gender>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bind()
    }
    
    override func setAttributes() {
        containerHStackView.do {
            $0.axis = .horizontal
            $0.spacing = 12
        }
        
        manButton.do {
            $0.tag = Gender.man.rawValue
            $0.configuration = .genderStyle(.man)
        }
        
        womanButton.do {
            $0.tag = Gender.woman.rawValue
            $0.configuration = .genderStyle(.woman)
        }
    }
    
    override func setHierarchy() {
        addSubview(containerHStackView)
    }
    
    override func setLayout() {
        containerHStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension GenderInputView {

    private func bind() {
        selectedGender
            .bind(with: self) { owner, gender in
                switch gender {
                case .man:
                    owner.manButton.configuration?.baseBackgroundColor = .MGC.whiteGreen
                    owner.womanButton.configuration?.baseBackgroundColor = .MGC.white
                    
                case .woman:
                    owner.manButton.configuration?.baseBackgroundColor = .MGC.white
                    owner.womanButton.configuration?.baseBackgroundColor = .MGC.whiteGreen
                }
            }
            .disposed(by: disposeBag)
        
        manButton.rx.tap.asDriver()
            .map { Gender.man }
            .drive(with: self) { owner, type in
                owner.selectedGender.accept(type)
            }
            .disposed(by: disposeBag)
        
        womanButton.rx.tap.asDriver()
            .map { Gender.woman }
            .drive(with: self) { owner, type in
                owner.selectedGender.accept(type)
            }
            .disposed(by: disposeBag)
    }
}
