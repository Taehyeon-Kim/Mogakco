//
//  PhoneEntryViewController.swift
//  Mogakco
//
//  Created by taekki on 2022/11/10.
//

import UIKit

import RxCocoa
import RxSwift

final class PhoneEntryViewController: BaseViewController {
    
    // MARK: Constants
    
    enum Metric {
        static let padding = 16.adjustedWidth
        static let textFieldLeftPadding = 12.0
        static let titleLabelTop = 125.adjustedHeight
        static let phoneEntryFieldTop = 65.adjustedHeight
        static let phoneEntryFieldHeight = 47.adjustedHeight
        static let verificationCodeButtonTop = 72.adjustedHeight
        static let verificationCodeButtonHeight = 48.adjustedHeight
    }
    
    enum Text {
        static let titleLabel = """
        새싹 서비스 이용을 위해
        휴대폰 번호를 입력해주세요
        """
        static let phoneEntryField = "휴대폰 번호(-없이 숫자만 입력)"
        static let verificationCodeButtonTitle = "인증 문자 받기"
    }
    
    // MARK: UI
    
    private let titleLabel = UILabel()
    private let phoneEntryField = UITextField()
    private let verificationCodeButton = SSButton(.disable)
    
    // MARK: Properties
    
    var viewModel: PhoneEntryViewModel
    
    // MARK: Initializing
    
    init(viewModel: PhoneEntryViewModel) {
        self.viewModel = viewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    // MARK: Override Methods
   
    override func setAttributes() {
        view.backgroundColor = .MGC.white
        
        titleLabel.do {
            $0.numberOfLines = 0
            $0.text = Text.titleLabel
            $0.setTypoStyle(.display1, alignment: .center)
        }
        
        phoneEntryField.do {
            $0.placeholder = Text.phoneEntryField
            $0.font = .init(.regular, 14)
            $0.keyboardType = .phonePad
            $0.setBottomBorder(with: .MGC.gray3, width: 1)
            $0.setLeftPadding(to: Metric.textFieldLeftPadding)
            $0.becomeFirstResponder()
        }
        
        verificationCodeButton.do {
            $0.title = Text.verificationCodeButtonTitle
        }
    }
    
    override func setHierarchy() {
        view.addSubviews(titleLabel, phoneEntryField, verificationCodeButton)
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Metric.titleLabelTop)
            $0.centerX.equalToSuperview()
        }
        
        phoneEntryField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Metric.phoneEntryFieldTop)
            $0.directionalHorizontalEdges.equalToSuperview().inset(Metric.padding)
            $0.height.equalTo(Metric.phoneEntryFieldHeight)
        }
        
        verificationCodeButton.snp.makeConstraints {
            $0.top.equalTo(phoneEntryField.snp.bottom).offset(Metric.verificationCodeButtonTop)
            $0.directionalHorizontalEdges.equalToSuperview().inset(Metric.padding)
            $0.height.equalTo(Metric.verificationCodeButtonHeight)
        }
    }
}

extension PhoneEntryViewController: Bindable {
    
    func bind() {
        let input = PhoneEntryViewModel.Input(
            phoneEntryText: phoneEntryField.rx.text.orEmpty,
            buttonTrigger: verificationCodeButton.button.rx.tap
        )
        let output = viewModel.transform(input: input)
        
        output.phoneEntryText
            .drive(phoneEntryField.rx.text)
            .disposed(by: disposeBag)
        
        output.isEnabled
            .emit(to: verificationCodeButton.button.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.isEnabled
            .withUnretained(self)
            .emit { view, isEnabled in
                view.verificationCodeButton.buttonStyle = isEnabled ? .fill : .disable
            }
            .disposed(by: disposeBag)
        
        output.isSucceedVerification
            .drive { [weak self] _ in
                // 토스트 성공 메시지 넣기
                let firebaseRepository = FirebaseAuthRepositoryImpl()
                let viewModel = PhoneVerificationViewModel(firebaseRepository: firebaseRepository)
                let viewController = PhoneVerificationViewController(viewModel: viewModel)
                self?.transition(to: viewController)
            }
            .disposed(by: disposeBag)
        
        output.isErrorVerification
            .drive { _ in
                // 토스트 에러 메시지 넣기
            }
            .disposed(by: disposeBag)
    }
}

extension PhoneEntryViewController {
    
    private func transition(to viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}
