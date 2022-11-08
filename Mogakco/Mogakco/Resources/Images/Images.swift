//
//  Images.swift
//  Mogakco
//
//  Created by taekki on 2022/11/07.
//

import UIKit

extension UIImage {
    
    func resized(width: CGFloat, height: CGFloat) -> UIImage {
        let size = CGSize(width: width, height: height)
        let render = UIGraphicsImageRenderer(size: size)
        let renderImage = render.image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
        return renderImage
    }
    
    func resized(side: CGFloat) -> UIImage {
        return self.resized(width: side, height: side)
    }
}

extension UIImage {
    
    // Splash
    static var imgSplashLogo: UIImage? { return UIImage(named: "splash_logo") }
    static var imgSplashText: UIImage? { return UIImage(named: "txt") }
}
