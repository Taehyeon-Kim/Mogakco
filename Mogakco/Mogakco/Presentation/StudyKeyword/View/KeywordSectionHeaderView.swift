//
//  KeywordSectionHeaderView.swift
//  Mogakco
//
//  Created by taekki on 2022/11/26.
//

import UIKit

final class KeywordSectionHeaderView: UICollectionReusableView {
    
    private let titleLabel = UILabel()
    
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
        addSubview(titleLabel)
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
    private func setAttributes() {
        titleLabel.do {
            $0.font = .notoSansR(12)
            $0.setLineHeight(18)
            $0.textColor = .MGC.black
        }
    }
}

extension KeywordSectionHeaderView {
    
    func configure(with title: String) {
        titleLabel.text = title
    }
}
