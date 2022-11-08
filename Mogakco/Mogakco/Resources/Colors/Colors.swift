//
//  Colors.swift
//  Mogakco
//
//  Created by taekki on 2022/11/07.
//

import UIKit

extension UIColor {
    
    static func makeColor(from hex: String) -> UIColor {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >>  8) & 0xFF) / 255.0
        let blue = Double((rgb >>  0) & 0xFF) / 255.0
        
        return .init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

extension UIColor {
    
    enum Brand {
        static let green = makeColor(from: "#49DC92")
        static let whiteGreen = makeColor(from: "#CDF4E1")
        static let yellowGreen = makeColor(from: "#B2EB61")
    }
    
    enum System {
        static let success = makeColor(from: "#628FE5")
        static let error = makeColor(from: "#E9666B")
        static let focus = makeColor(from: "#333333")
    }
    
    enum Gray {
        static let black = makeColor(from: "#333333")
        static let white = makeColor(from: "#FFFFFF")
        static let gray7 = makeColor(from: "#888888")
        static let gray6 = makeColor(from: "#AAAAAA")
        static let gray5 = makeColor(from: "#BDBDBD")
        static let gray4 = makeColor(from: "#D1D1D1")
        static let gray3 = makeColor(from: "#E2E2E2")
        static let gray2 = makeColor(from: "#EFEFEF")
        static let gray1 = makeColor(from: "#F7F7F7")
    }
}
