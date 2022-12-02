//
//  BirthViewController.swift
//  Mogakco
//
//  Created by taekki on 2022/11/10.
//

import UIKit

import RxCocoa
import RxSwift

final class BirthViewController: BaseViewController {
    
    private let navigationBar = MGCNavigationBar()
    private let textLabel = UILabel()
    private lazy var containerHStackView = UIStackView(arrangedSubviews: [yearInputView, monthInputView, dayInputView])
    private let yearInputView = BirthInputView()
    private let monthInputView = BirthInputView()
    private let dayInputView = BirthInputView()
    private let verificationCodeButton = MGCButton(.fill)
    
    private let datePickerButton = MyButton()
    private let datePicker = UIDatePicker()
    private let doneButton = UIBarButtonItem(systemItem: .done)
    
    let dateValue = BehaviorRelay(value: Date(timeIntervalSince1970: 0))
    
    // MARK: Properties
    var viewModel: BirthViewModel
    
    // MARK: Initializing
    init(viewModel: BirthViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        createDatePicker()
    }
    
    override func setAttributes() {
        view.backgroundColor = .MGC.white
        
        navigationBar.do {
            $0.leftBarItem = .back
        }
        
        textLabel.do {
            $0.text = """
            생년월일을 알려주세요
            """
            $0.numberOfLines = 0
            $0.setTypoStyle(.display1, alignment: .center)
        }
        
        containerHStackView.do {
            $0.axis = .horizontal
            $0.spacing = 4
            $0.distribution = .fillEqually
        }

        yearInputView.do {
            $0.title = "년"
            $0.placeholder = "1990"
        }
        
        monthInputView.do {
            $0.title = "월"
            $0.placeholder = "1"
        }
        
        dayInputView.do {
            $0.title = "일"
            $0.placeholder = "1"
        }
        
        verificationCodeButton.do {
            $0.title = "다음"
        }
    }
    
    override func setHierarchy() {
        view.addSubviews(
            navigationBar,
            textLabel,
            containerHStackView,
            datePickerButton,
            verificationCodeButton
        )
    }
    
    override func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        textLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(97)
            $0.centerX.equalToSuperview()
        }
        
        containerHStackView.snp.makeConstraints {
            $0.top.equalTo(textLabel.snp.bottom).offset(80)
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
        
        datePickerButton.snp.makeConstraints {
            $0.edges.equalTo(containerHStackView)
        }
        
        verificationCodeButton.snp.makeConstraints {
            $0.top.equalTo(containerHStackView.snp.bottom).offset(72)
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
    }
}

extension BirthViewController: Bindable {
    
    func bind() {
        navigationBar.leftButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
        datePickerButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.datePickerButton.becomeFirstResponder()
            }
            .disposed(by: disposeBag)
    
        doneButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.datePickerButton.resignFirstResponder()
            }
            .disposed(by: disposeBag)
        
        datePicker.rx.value
            .bind(with: self) { owner, date in
                owner.dateValue.accept(date)
            }
            .disposed(by: disposeBag)
        
        dateValue
            .bind(with: self) { owner, date in
                print(date)
                let components = Calendar.current.dateComponents([.year, .month, .day], from: date)
                owner.yearInputView.value = String(components.year!)
                owner.monthInputView.value = String(components.month!)
                owner.dayInputView.value = String(components.day!)
            }
            .disposed(by: disposeBag)
        
        verificationCodeButton.button.rx.tap
            .map { ValidatorImpl().isValid(age: self.dateValue.value) }
            .bind { [weak self] isPossible in
                if isPossible {
                    self?.viewModel.storeBirth("221210")
                    let container = DependencyContainer()
                    let viewController = container.makeEmailViewController()
                    self?.transition(to: viewController)
                    
                } else {
                    // show error popup
                }
            }
            .disposed(by: disposeBag)
    }
    
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.setItems([doneButton], animated: true)
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko-KR")
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        datePickerButton.inputAccessoryView = toolbar
        datePickerButton.inputView = datePicker
    }
}

extension BirthViewController {

    private func transition(to viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}
