//
//  ExpandableCardViewSectionHeader.swift
//  Mogakco
//
//  Created by taekki on 2022/11/30.
//

import UIKit

import SnapKit
import Then

final class ExpandableCardViewSectionHeader: UICollectionReusableView {
    
    let backgroundImageView = UIImageView()
    let characterImageView = UIImageView()
    let button = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
        setAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {
        addSubviews(backgroundImageView, characterImageView, button)
    }
    
    private func setLayout() {
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setAttributes() {
        backgroundImageView.do {
            $0.backgroundColor = .yellow
            $0.layer.masksToBounds = true
            $0.makeRounded(radius: 8)
        }
    }
}
