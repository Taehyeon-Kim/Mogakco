//
//  BaseCollectionViewCell.swift
//  Mogakco
//
//  Created by taekki on 2022/11/08.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setAttributes()
        setHierarchy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setAttributes() {}
    func setHierarchy() {}
    func setLayout() {}
}
