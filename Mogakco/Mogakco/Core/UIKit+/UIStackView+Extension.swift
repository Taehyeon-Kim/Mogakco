//
//  UIStackView+Extension.swift
//  Mogakco
//
//  Created by taekki on 2022/11/11.
//

import UIKit

extension UIStackView {
    
    public func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}
