//
//  NicknameViewController.swift
//  Mogakco
//
//  Created by taekki on 2022/11/10.
//

import UIKit

import RxCocoa
import RxSwift

final class NicknameViewController: BaseViewController {
    
    // MARK: UI
    
    private let textLabel = UILabel()
    private let textField = UITextField()
    private let nextButton = SSButton(.disable)
    
    // MARK: Properties
    
    var viewModel: NicknameViewModel
    
    // MARK: Initializing
    
    init(viewModel: NicknameViewModel) {
        self.viewModel = viewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func setAttributes() {
        view.backgroundColor = .Gray.white
        
        textLabel.do {
            $0.text = """
            닉네임을 입력해 주세요
            """
            $0.numberOfLines = 0
            $0.setTypoStyle(.display1, alignment: .center)
        }
        
        textField.do {
            $0.placeholder = "10자 이내로 입력"
            $0.font = .init(.regular, 14)
            $0.setBottomBorder(with: .Gray.gray3, width: 1)
            $0.setLeftPadding(to: 12)
            $0.becomeFirstResponder()
        }
        
        nextButton.do {
            $0.title = "다음"
        }
    }
    
    override func setHierarchy() {
        view.addSubview(textLabel)
        view.addSubview(textField)
        view.addSubview(nextButton)
    }
    
    override func setLayout() {
        textLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(125)
            $0.centerX.equalToSuperview()
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(textLabel.snp.bottom).offset(77)
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(47)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(72)
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
    }
}

extension NicknameViewController: Bindable {
    
    func bind() {
        let input = NicknameViewModel.Input(
            changedText: textField.rx.text.orEmpty,
            nextButtonTrigger: nextButton.button.rx.tap
        )
        let output = viewModel.transform(input: input)
        
        output.nickname
            .drive(textField.rx.text)
            .disposed(by: disposeBag)
        
        output.isEnabled
            .withUnretained(self)
            .emit { `self`, isEnabled in
                self.nextButton.buttonStyle = isEnabled ? .fill : .disable
            }
            .disposed(by: disposeBag)
        
        output.nextButtonTrigger
            .drive { [weak self] _ in
                let viewController = BirthViewController()
                self?.transition(to: viewController)
            }
            .disposed(by: disposeBag)
    }
}

extension NicknameViewController {
    
    private func transition(to viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}
