//
//  EmailViewController.swift
//  Mogakco
//
//  Created by taekki on 2022/11/10.
//

import UIKit

final class EmailViewController: BaseViewController {
    
    private let navigationBar = MGCNavigationBar()
    private let textLabel = UILabel()
    private let subtextLabel = UILabel()
    private let textField = UITextField()
    private let verificationCodeButton = MGCButton(.disable)
    
    private let viewModel: EmailViewModel!
    
    init(viewModel: EmailViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func setAttributes() {
        view.backgroundColor = .MGC.white
        
        navigationBar.do {
            $0.leftBarItem = .back
        }
        
        textLabel.do {
            $0.text = "이메일을 입력해 주세요"
            $0.numberOfLines = 0
            $0.setTypoStyle(.display1, alignment: .center)
        }
        
        subtextLabel.do {
            $0.text = "휴대폰 번호 변경 시 인증을 위해 사용해요"
            $0.numberOfLines = 0
            $0.setTypoStyle(.title2, alignment: .center)
            $0.textColor = .MGC.gray7
        }
        
        textField.do {
            $0.placeholder = "SeSAC@email.com"
            $0.font = .init(.regular, 14)
            $0.setBottomBorder(with: .MGC.gray3, width: 1)
            $0.setLeftPadding(to: 12)
            $0.becomeFirstResponder()
        }
        
        verificationCodeButton.do {
            $0.title = "다음"
        }
    }
    
    override func setHierarchy() {
        view.addSubviews(
            navigationBar,
            textLabel,
            subtextLabel,
            textField,
            verificationCodeButton
        )
    }
    
    override func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        textLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(80)
            $0.centerX.equalToSuperview()
        }
        
        subtextLabel.snp.makeConstraints {
            $0.top.equalTo(textLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(textLabel.snp.bottom).offset(77)
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(47)
        }
        
        verificationCodeButton.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(72)
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
    }
}

extension EmailViewController: Bindable {
    
    func bind() {
        let input = EmailViewModel.Input(
            changedText: textField.rx.text.orEmpty,
            nextButtonTrigger: verificationCodeButton.button.rx.tap
        )
        let output = viewModel.transform(input: input)
        
        output.isEnabled
            .withUnretained(self)
            .emit { `self`, isEnabled in
                self.verificationCodeButton.buttonStyle = isEnabled ? .fill : .disable
            }
            .disposed(by: disposeBag)
        
        output.nextButtonTrigger
            .asObservable()
            .withUnretained(self)
            .subscribe { owner, _ in
                owner.viewModel.storeEmail()
                let container = DependencyContainer()
                let viewController = container.makeGenderViewController()
                owner.transition(to: viewController)
            }
            .disposed(by: disposeBag)
    }
}

extension EmailViewController {
    
    private func transition(to viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}
