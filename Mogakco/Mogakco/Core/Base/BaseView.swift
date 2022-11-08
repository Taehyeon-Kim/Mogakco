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
        setLayout()
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setAttributes() {}
    open func setLayout() {}
}
