//
//  MyInfoItemCell.swift
//  Mogakco
//
//  Created by taekki on 2022/11/21.
//

import UIKit

import SnapKit
import Then
import RxSwift

final class MyInfoItemCell: BaseCollectionViewCell {
    
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let accessoryImageView = UIImageView()
    private let underLineView = UIView()

    override func setAttributes() {
        contentView.backgroundColor = .clear
        
        iconImageView.do {
            $0.contentMode = .scaleAspectFit
        }
        
        titleLabel.do {
            $0.textColor = .black
            $0.font = .init(.regular, 16)
        }
        
        accessoryImageView.do {
            $0.contentMode = .scaleAspectFit
        }
        
        underLineView.do {
            $0.backgroundColor = .Gray.gray2
        }
    }
    
    override func setHierarchy() {
        contentView.addSubviews(
            iconImageView,
            titleLabel,
            accessoryImageView,
            underLineView
        )
    }
    
    override func setLayout() {
        iconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(17)
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(12)
            $0.centerY.equalTo(iconImageView.snp.centerY)
        }
        
        accessoryImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }
        
        underLineView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(17)
            $0.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview()
        }
    }
}

extension MyInfoItemCell {
    
    func configure(with viewModel: MyInfoItemCellViewModel) {
        iconImageView.image = viewModel.iconImage
        titleLabel.text = viewModel.title
        accessoryImageView.image = viewModel.accessoryImage
        
        titleLabel.font = viewModel.isProfile ? .init(.medium, 16) : .init(.regular, 16)
    }
}
