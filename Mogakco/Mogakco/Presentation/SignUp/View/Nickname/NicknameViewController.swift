//
//  NicknameViewController.swift
//  Mogakco
//
//  Created by taekki on 2022/11/10.
//

import UIKit

import RxCocoa
import RxSwift
import Toast

final class NicknameViewController: BaseViewController {
    
    // MARK: Properties
    private let rootView = NicknameView()
    private var viewModel: NicknameViewModel
    
    // MARK: Initializer
    init(viewModel: NicknameViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Life Cycle
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
}

extension NicknameViewController: Bindable {
    
    func bind() {
        let input = NicknameViewModel.Input(
            changedText: rootView.textField.rx.text.orEmpty.asObservable(),
            nextButtonDidTap: rootView.nextButton.button.rx.tap.asObservable()
        )
        let output = viewModel.transform(input: input)
        
        output.isNextButtonEnabled
            .drive(with: self) { owner, isEnabled in
                owner.rootView.nextButton.buttonStyle = isEnabled ? .fill : .disable
            }
            .disposed(by: disposeBag)
        
        output.isSucceed
            .drive(with: self) { owner, _ in
                let container = DependencyContainer()
                let viewController = container.makeBirthViewController()
                owner.transition(to: viewController)
            }
            .disposed(by: disposeBag)
        
        output.errorOccured
            .drive(with: self) { owner, error in
                owner.rootView.makeToast(error.localizedDescription, duration: TimeInterval(0.5), position: .top)
            }
            .disposed(by: disposeBag)
    }
}

extension NicknameViewController {
    
    private func transition(to viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}
