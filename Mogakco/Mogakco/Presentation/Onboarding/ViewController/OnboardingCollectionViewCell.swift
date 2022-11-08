//
//  OnboardingCollectionViewCell.swift
//  Mogakco
//
//  Created by taekki on 2022/11/08.
//

import UIKit

import SnapKit
import Then

struct Onboarding {
    let message: String
    let imagePath: String
}

final class OnboardingCollectionViewCell: BaseCollectionViewCell {
    
    private enum Metric {
        static let messageTopMargin = 72.0.adjustedHeight
        static let messageWidth = 227.0.adjustedWidth
        static let messageHeight = 76.0.adjustedHeight
        static let imageTopMargin = 56.0.adjustedHeight
        static let imageSize = 360.0.adjustedWidth
    }
    
    private let messageLabel = UILabel()
    private let imageView = UIImageView()
    
    override func setAttributes() {
        messageLabel.do {
            $0.numberOfLines = 0
        }
        
        imageView.do {
            $0.contentMode = .scaleAspectFill
        }
    }
    
    override func setHierarchy() {
        contentView.addSubview(messageLabel)
        contentView.addSubview(imageView)
    }
    
    override func setLayout() {
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(Metric.messageTopMargin)
            $0.width.equalTo(Metric.messageWidth)
            $0.height.equalTo(Metric.messageHeight)
            $0.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(messageLabel.snp.bottom).offset(Metric.imageTopMargin)
            $0.size.equalTo(Metric.imageSize)
            $0.centerX.equalToSuperview()
        }
    }
}

extension OnboardingCollectionViewCell {

    func configure(with data: Onboarding) {
        messageLabel.text = data.message
        imageView.image = UIImage(named: data.imagePath)
    }
}
