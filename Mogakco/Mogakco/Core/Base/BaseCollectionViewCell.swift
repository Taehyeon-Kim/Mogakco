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
        
        configureAttributes()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureAttributes() {}
    func configureLayout() {}
}
