//
//  BaseView.swift
//  Mogakco
//
//  Created by taekki on 2022/11/08.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setAttributes()
        setHierarchy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAttributes() {}
    func setHierarchy() {}
    func setLayout() {}
}
