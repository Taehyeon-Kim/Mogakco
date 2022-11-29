//
//  ExpandableCardViewItemSectionHeader.swift
//  Mogakco
//
//  Created by taekki on 2022/11/29.
//

import UIKit

import SnapKit
import Then

final class ExpandableCardViewItemSectionHeader: UICollectionReusableView {
    
    let titleLabel = UILabel()
    let disclosureIndicator = UIButton()

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
        addSubviews(titleLabel, disclosureIndicator)
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        disclosureIndicator.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
    
    private func setAttributes() {
        titleLabel.do {
            $0.textColor = .MGC.black
            $0.font = .notoSansR(12)
            $0.text = "header"
        }
        
        disclosureIndicator.do {
            $0.setImage(.icnMoreArrow, for: .normal)
            $0.isHidden = true
        }
    }
}

extension ExpandableCardViewItemSectionHeader {
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
}
