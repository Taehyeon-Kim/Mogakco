//
//  PhoneVerificationViewController.swift
//  Mogakco
//
//  Created by taekki on 2022/11/10.
//

import UIKit

import RxCocoa
import RxSwift

final class PhoneVerificationViewController: BaseViewController {

    // MARK: Constants
    
    enum Metric {
        static let padding = 16.adjustedWidth
        static let textFieldLeftPadding = 12.0
        static let titleLabelTop = 125.adjustedHeight
        static let containerHStackViewTop = 77
        static let containerHStackViewHeight = 47
        static let resendButtonWidth = 72
        static let verificationCodeButtonTop = 72.adjustedHeight
        static let verificationCodeButtonHeight = 48.adjustedHeight
    }
    
    enum Text {
        static let titleLabel = "인증번호가 문자로 전송되었어요"
        static let verificationCodeField = "인증번호 입력"
        static let resendButton = "재전송"
        static let verificationCodeButton = "인증하고 시작하기"
    }
    
    // MARK: UI
    
    private let titleLabel = UILabel()
    private lazy var containerHStackView = UIStackView(
        arrangedSubviews: [verificationCodeField, resendButton]
    )
    private let verificationCodeField = UITextField()
    private let resendButton = SSButton(.fill)
    private let verificationCodeButton = SSButton(.disable)
    
    // MARK: Properties
    
    var viewModel: PhoneVerificationViewModel
    
    // MARK: Initializing
    
    init(viewModel: PhoneVerificationViewModel) {
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
        view.backgroundColor = .Gray.white
        
        titleLabel.do {
            $0.text = Text.titleLabel
            $0.numberOfLines = 0
            $0.setTypoStyle(.display1, alignment: .center)
        }
        
        containerHStackView.do {
            $0.axis = .horizontal
            $0.spacing = 12
        }
        
        resendButton.do {
            $0.title = Text.resendButton
        }
        
        verificationCodeField.do {
            $0.placeholder = Text.verificationCodeField
            $0.font = .init(.regular, 14)
            $0.keyboardType = .numberPad
            $0.textContentType = .oneTimeCode
            $0.setBottomBorder(with: .Gray.gray3, width: 1)
            $0.setLeftPadding(to: Metric.textFieldLeftPadding)
            $0.becomeFirstResponder()
        }
        
        verificationCodeButton.do {
            $0.title = Text.verificationCodeButton
        }
    }
    
    override func setHierarchy() {
        view.addSubviews(titleLabel, containerHStackView, verificationCodeButton)
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Metric.titleLabelTop)
            $0.centerX.equalToSuperview()
        }
        
        containerHStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Metric.containerHStackViewTop)
            $0.directionalHorizontalEdges.equalToSuperview().inset(Metric.padding)
            $0.height.equalTo(Metric.containerHStackViewHeight)
        }
        
        resendButton.snp.makeConstraints {
            $0.width.equalTo(Metric.resendButtonWidth)
        }
        
        verificationCodeButton.snp.makeConstraints {
            $0.top.equalTo(verificationCodeField.snp.bottom).offset(Metric.verificationCodeButtonTop)
            $0.directionalHorizontalEdges.equalToSuperview().inset(Metric.padding)
            $0.height.equalTo(Metric.verificationCodeButtonHeight)
        }
    }
}

extension PhoneVerificationViewController: Bindable {
    
    func bind() {
        let input = PhoneVerificationViewModel.Input(
            verificationCode: verificationCodeField.rx.text.orEmpty,
            resendButtonTrigger: resendButton.button.rx.tap,
            verifyButtonTrigger: verificationCodeButton.button.rx.tap
        )
        let output = viewModel.transform(input: input)
        
        output.verificationCode
            .drive(verificationCodeField.rx.text)
            .disposed(by: disposeBag)
        
        output.isEnabled
            .drive { [weak self] isEnabled in
                self?.verificationCodeButton.buttonStyle = isEnabled ? .fill : .disable
            }
            .disposed(by: disposeBag)
        
        output.isSucceedVerification
            .drive { [weak self] idToken in
                // 토스트 성공 메시지 넣기
                print("성공: \(UserDefaultsManager.idToken)")
            }
            .disposed(by: disposeBag)
        
        output.isErrorVerification
            .drive { _ in
                print("실패: \(UserDefaultsManager.idToken)")
            }
            .disposed(by: disposeBag)
    }
}
