//
//  CALayer+.swift
//  Mogakco
//
//  Created by taekki on 2022/11/26.
//

import UIKit

extension CALayer {

    func applyShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x xCoordinate: CGFloat = 0,
        y yCoordinate: CGFloat = 2,
        blur: CGFloat = 4
    ) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: xCoordinate, height: yCoordinate)
        shadowRadius = blur / 2.0
    }
}
