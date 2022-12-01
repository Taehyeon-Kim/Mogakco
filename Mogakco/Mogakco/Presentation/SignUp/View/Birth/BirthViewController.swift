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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        createDatePicker()
    }
    
    override func setAttributes() {
        view.backgroundColor = .MGC.white
        
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
            textLabel,
            containerHStackView,
            datePickerButton,
            verificationCodeButton
        )
    }
    
    override func setLayout() {
        textLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(97)
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
        datePickerButton.rx.tap
            .bind { [weak self] _ in
                self?.datePickerButton.becomeFirstResponder()
            }
            .disposed(by: disposeBag)
    
        doneButton.rx.tap
            .bind { [weak self] _ in
                self?.datePickerButton.resignFirstResponder()
            }
            .disposed(by: disposeBag)
        
        datePicker.rx.value
            .withUnretained(self)
            .bind { `self`, date in
                self.dateValue.accept(date)
            }
            .disposed(by: disposeBag)
        
        dateValue
            .withUnretained(self)
            .bind { `self`, date in
                print(date)
                let components = Calendar.current.dateComponents([.year, .month, .day], from: date)
                self.yearInputView.value = String(components.year!)
                self.monthInputView.value = String(components.month!)
                self.dayInputView.value = String(components.day!)
            }
            .disposed(by: disposeBag)
        
        verificationCodeButton.button.rx.tap
            .bind { [weak self] _ in
                let viewController = EmailViewController(viewModel: EmailViewModel())
                self?.transition(to: viewController)
                self?.saveBirth()
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
    
    private func saveBirth() {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSS'Z"
        
        let birth = formatter.string(from: dateValue.value)
        UserDefaultsManager.birth = birth
    }
    
    private func transition(to viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}
