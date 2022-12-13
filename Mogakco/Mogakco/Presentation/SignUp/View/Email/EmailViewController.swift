//
//  EmailViewController.swift
//  Mogakco
//
//  Created by taekki on 2022/11/10.
//

import UIKit

final class EmailViewController: BaseViewController {

    private let rootView = EmailRootView()
    private let viewModel: EmailViewModel!
    
    init(viewModel: EmailViewModel) {
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

extension EmailViewController: Bindable {
    
    func bind() {
        let input = EmailViewModel.Input(
            emailValue: rootView.textField.rx.text.orEmpty.asObservable(),
            nextButtonTrigger: rootView.nextButton.button.rx.tap.asObservable(),
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
        
        output.success
            .drive(with: self) { owner, _ in
                let container = DependencyContainer()
                let viewController = container.makeGenderViewController()
                owner.transition(to: viewController)
            }
            .disposed(by: disposeBag)
        
        output.error
            .drive(with: self) { owner, message in
                owner.view.makeToast(message, position: .top)
            }
            .disposed(by: disposeBag)
    }
}

extension EmailViewController {
    
    private func transition(to viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}
