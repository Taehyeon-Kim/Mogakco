//
//  GenderFilterView.swift
//  Mogakco
//
//  Created by taekki on 2022/11/25.
//

import UIKit

import RxCocoa
import RxSwift

final class GenderFilterView: BaseView {
    
    enum State: Int, CaseIterable {
        case whole = 0
        case man
        case woman
        
        var title: String {
            switch self {
            case .whole: return "전체"
            case .man: return "남자"
            case .woman: return "여자"
            }
        }
    }
    
    private lazy var buttonStack = UIStackView(
        arrangedSubviews: [wholeButton, manButton, womanButton]
    )
    
    private let wholeButton = UIButton()
    private let manButton = UIButton()
    private let womanButton = UIButton()
    
    var selectedState = PublishRelay<State>()
    var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bind()
    }
    
    override func setHierarchy() {
        addSubview(buttonStack)
    }
    
    override func setLayout() {
        buttonStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setAttributes() {
        buttonStack.do {
            $0.axis = .vertical
            $0.distribution = .fillEqually
            $0.makeRounded(radius: 8)
        }
        
        setAppearance(for: .whole)
    }
    
    private func initButtonAppearance() {
        for (state, button) in zip(State.allCases, buttonStack.arrangedSubviews) {
            guard let button = button as? UIButton else { return }
            button.setTitle(state.title, for: .normal)
            button.setTitleColor(.Gray.black, for: .normal)
            button.titleLabel?.font = .init(.regular, 14)
            button.backgroundColor = .white
        }
    }
    
    private func setAppearance(for selectedState: State) {
        initButtonAppearance()
        
        guard let buttonView = buttonStack.arrangedSubviews[selectedState.rawValue] as? UIButton else { return }
        buttonView.backgroundColor = .Brand.green
        buttonView.setTitleColor(.white, for: .normal)
    }
    
    private func bind() {
        wholeButton.rx.tap
            .map { State.whole }
            .bind(with: self) { `self`, state in
                self.selectedState.accept(state)
            }
            .disposed(by: disposeBag)
        
        manButton.rx.tap
            .map { State.man }
            .bind(with: self) { `self`, state in
                self.selectedState.accept(state)
            }
            .disposed(by: disposeBag)
        
        womanButton.rx.tap
            .map { State.woman }
            .bind(with: self) { `self`, state in
                self.selectedState.accept(state)
            }
            .disposed(by: disposeBag)
        
        selectedState
            .bind(with: self) { `self`, state in
                self.setAppearance(for: state)
            }
            .disposed(by: disposeBag)
    }
}
