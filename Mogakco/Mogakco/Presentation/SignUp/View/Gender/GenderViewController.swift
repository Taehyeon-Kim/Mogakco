//
//  GenderViewController.swift
//  Mogakco
//
//  Created by taekki on 2022/11/10.
//

import UIKit

final class GenderViewController: BaseViewController {
    
    private let rootView = GenderRootView()
    private let viewModel: GenderViewModel!
    
    init(viewModel: GenderViewModel) {
        self.viewModel = viewModel
    }
    
    override func loadView() {
        self.view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
}

extension GenderViewController: Bindable {
    
    func bind() {
        let input = GenderViewModel.Input(
            selectedGender: rootView.genderView.selectedGender.map { $0.rawValue }.asObservable(),
            nextButtonDidTap: rootView.nextButton.button.rx.tap.asObservable(),
            backButtonDidTap: rootView.navigationBar.leftButton.rx.tap.asObservable()
        )
        let output = viewModel.transform(input: input)
        
        output.isBackButtonTapped
            .drive(with: self) { owner, _ in
                owner.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
        output.isEnabled
            .map { $0 ? MGCButtonStyle.fill : MGCButtonStyle.disable }
            .drive(with: self) { owner, style in
                owner.rootView.nextButton.buttonStyle = style
            }
            .disposed(by: disposeBag)
    }
}
