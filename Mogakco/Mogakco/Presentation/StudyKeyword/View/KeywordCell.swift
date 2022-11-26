//
//  KeywordCell.swift
//  Mogakco
//
//  Created by taekki on 2022/11/26.
//

import UIKit

final class KeywordCell: BaseCollectionViewCell {
    
    private let titleLabel = UILabel()
    
    private let hPadding: CGFloat = 16
    private let vPadding: CGFloat = 5
    
    override func setHierarchy() {
        contentView.addSubview(titleLabel)
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.directionalVerticalEdges.equalToSuperview().inset(vPadding)
            $0.directionalHorizontalEdges.equalToSuperview().inset(hPadding)
        }
    }
    
    override func setAttributes() {
        contentView.do {
            $0.backgroundColor = .clear
            $0.makeRounded(radius: 8)
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.MGC.gray4.cgColor
        }
    }
}

extension KeywordCell {
    
    func configure(with text: String) {
        titleLabel.text = text
    }
}
