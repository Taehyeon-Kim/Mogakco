//
//  SplashViewController.swift
//  Mogakco
//
//  Created by taekki on 2022/11/07.
//

import UIKit

import SnapKit
import Then

final class SplashViewController: BaseViewController {
    
    private enum Metric {
        static let logoTopMargin = 175.0
        static let logoWidth = 220.0
        static let logoHeight = 264.0
        static let textTopMargin = 34.0
        static let textWidth = 292.0
        static let textHeight = 101.0
    }
    
    private let splashLogoImageView = UIImageView()
    private let splashTextImageView = UIImageView()
    
    override func setAttributes() {
        view.backgroundColor = .systemBackground
        
        splashLogoImageView.do {
            $0.image = .imgSplashLogo
        }
        
        splashTextImageView.do {
            $0.image = .imgSplashText
        }
    }
    
    override func setHierarchy() {
        view.addSubview(splashLogoImageView)
        view.addSubview(splashTextImageView)
    }
    
    override func setLayout() {
        splashLogoImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Metric.logoTopMargin)
            $0.width.equalTo(Metric.logoWidth)
            $0.height.equalTo(Metric.logoHeight)
            $0.centerX.equalToSuperview()
        }
        
        splashTextImageView.snp.makeConstraints {
            $0.top.equalTo(splashLogoImageView.snp.bottom).offset(Metric.textTopMargin)
            $0.width.equalTo(Metric.textWidth)
            $0.height.equalTo(Metric.textHeight)
            $0.centerX.equalTo(splashLogoImageView.snp.centerX)
        }
    }
}
