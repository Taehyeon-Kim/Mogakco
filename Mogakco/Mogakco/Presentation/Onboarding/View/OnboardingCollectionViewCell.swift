//
//  OnboardingCollectionViewCell.swift
//  Mogakco
//
//  Created by taekki on 2022/11/08.
//

import UIKit

import SnapKit
import Then

final class OnboardingCollectionViewCell: BaseCollectionViewCell {
    
    private enum Metric {
        static let textTopMargin = 72.adjustedHeight
        static let textHeight = 76
        static let imageTopMargin = 56.adjustedHeight
        static let imageSize = 360.adjustedHeight
    }
    
    private let textLabel = UILabel()
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setAttributes() {
        textLabel.do {
            $0.numberOfLines = 0
            $0.textAlignment = .center
            $0.font = .init(.regular, 24)
        }
        
        imageView.do {
            $0.contentMode = .scaleAspectFill
        }
    }
    
    override func setHierarchy() {
        contentView.addSubview(textLabel)
        contentView.addSubview(imageView)
    }
    
    override func setLayout() {
        textLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Metric.textTopMargin)
            $0.height.equalTo(Metric.textHeight)
            $0.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(textLabel.snp.bottom).offset(Metric.imageTopMargin)
            $0.size.equalTo(Metric.imageSize)
            $0.centerX.equalToSuperview()
        }
    }
}

extension OnboardingCollectionViewCell {

    func configure(with data: Onboarding) {
        textLabel.text = data.text
        imageView.image = data.image
        
        highlightOnboardingText()
    }
    
    private func highlightOnboardingText() {
        for target in ["위치 기반", "스터디를 원하는 친구"] {
            if let text = textLabel.text, text.contains(target) {
                textLabel.highlight(target, color: .Brand.green)
            }
        }
    }
}
