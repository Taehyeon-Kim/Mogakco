//
//  GenderViewController.swift
//  Mogakco
//
//  Created by taekki on 2022/11/10.
//

import UIKit

final class GenderViewController: BaseViewController {
    
    private let textLabel = UILabel()
    private let subtextLabel = UILabel()
    private let genderInputView = GenderInputView()
    private let verificationCodeButton = MGCButton(.disable)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setAttributes() {
        view.backgroundColor = .MGC.white
        
        textLabel.do {
            $0.text = "성별을 선택해 주세요"
            $0.numberOfLines = 0
            $0.setTypoStyle(.display1, alignment: .center)
        }
        
        subtextLabel.do {
            $0.text = "새싹 찾기 기능을 이용하기 위해서 필요해요!"
            $0.numberOfLines = 0
            $0.setTypoStyle(.title2, alignment: .center)
            $0.textColor = .MGC.gray7
        }
        
        verificationCodeButton.do {
            $0.title = "다음"
        }
    }
    
    override func setHierarchy() {
        view.addSubview(textLabel)
        view.addSubview(subtextLabel)
        view.addSubview(genderInputView)
        view.addSubview(verificationCodeButton)
    }
    
    override func setLayout() {
        textLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(80)
            $0.centerX.equalToSuperview()
        }
        
        subtextLabel.snp.makeConstraints {
            $0.top.equalTo(textLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        genderInputView.snp.makeConstraints {
            $0.top.equalTo(subtextLabel.snp.bottom).offset(32)
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(120)
        }
        
        verificationCodeButton.snp.makeConstraints {
            $0.top.equalTo(genderInputView.snp.bottom).offset(32)
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
    }
}
