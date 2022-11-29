//
//  ExpandableCardViewItemCell.swift
//  Mogakco
//
//  Created by taekki on 2022/11/29.
//

import UIKit

import SnapKit
import Then

final class ExpandableCardViewItemCell: BaseCollectionViewCell {
    
    let button = MGCButton(.inactive)
    
    override func setAttributes() {
        contentView.backgroundColor = .clear
        contentView.layer.masksToBounds = false
        
        button.do {
            $0.title = "test"
        }
    }
    
    override func setHierarchy() {
        contentView.addSubview(button)
    }
    
    override func setLayout() {
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension ExpandableCardViewItemCell {
    
    func configure(with tagName: String) {
        button.title = tagName
    }
}
