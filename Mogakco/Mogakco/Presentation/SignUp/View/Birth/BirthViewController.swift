//
//  BirthViewController.swift
//  Mogakco
//
//  Created by taekki on 2022/11/10.
//

import UIKit

import RxCocoa
import RxSwift
import Toast

final class BirthViewController: BaseViewController {

    // MARK: UI
    private let rootView = BirthRootView()
    
    // MARK: Properties
    var viewModel: BirthViewModel
    
    // MARK: Initializing
    init(viewModel: BirthViewModel) {
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

// MARK: - Binding
extension BirthViewController: Bindable {
    
    func bind() {
        let input = BirthViewModel.Input(
            changedValue: rootView.datePicker.rx.date.asObservable(),
            doneButtonTrigger: rootView.doneButton.rx.tap.asObservable(),
            datePickerButtonTrigger: rootView.datePickerButton.rx.tap.asObservable(),
            nextButtonTrigger: rootView.nextButton.button.rx.tap.asObservable(),
            backButtonDidTap: rootView.navigationBar.leftButton.rx.tap.asObservable()
        )
        let output = viewModel.transform(input: input)
        
        output.isBackButtonTapped
            .drive(with: self) { owner, _ in
                owner.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
        output.year
            .emit(with: self) { owner, year in
                owner.rootView.yearInputView.value = year
            }
            .disposed(by: disposeBag)
        
        output.month
            .emit(with: self) { owner, month in
                owner.rootView.monthInputView.value = month
            }
            .disposed(by: disposeBag)
        
        output.day
            .emit(with: self) { owner, day in
                owner.rootView.dayInputView.value = day
            }
            .disposed(by: disposeBag)
        
        output.isEnabled
            .map { $0 ? MGCButtonStyle.fill : MGCButtonStyle.disable }
            .drive(with: self) { owner, style in
                owner.rootView.nextButton.buttonStyle = style
            }
            .disposed(by: disposeBag)
        
        output.doneButtonTrigger
            .drive(with: self) { owner, _ in
                owner.rootView.datePickerButton.resignFirstResponder()
            }
            .disposed(by: disposeBag)
        
        output.datePickerButtonTrigger
            .drive(with: self) { owner, _ in
                owner.rootView.datePickerButton.becomeFirstResponder()
            }
            .disposed(by: disposeBag)
        
        output.success
            .drive(with: self) { owner, _ in
                let container = DependencyContainer()
                let viewController = container.makeEmailViewController()
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

// MARK: - Transition
extension BirthViewController {

    private func transition(to viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}
