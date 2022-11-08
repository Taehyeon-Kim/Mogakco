//
//  Adjusted.swift
//  Mogakco
//
//  Created by taekki on 2022/11/08.
//

import UIKit

extension CGFloat {
    var adjustedWidth: CGFloat {
        let ratio: CGFloat = UIScreen.main.bounds.width / 375
        return self * ratio
    }
    
    var adjustedHeight: CGFloat {
        let ratio: CGFloat = UIScreen.main.bounds.height / 812
        return self * ratio
    }
}

extension Double {
    var adjustedWidth: Double {
        let ratio: Double = Double(UIScreen.main.bounds.width / 375)
        return self * ratio
    }
    
    var adjustedHeight: Double {
        let ratio: Double = Double(UIScreen.main.bounds.height / 812)
        return self * ratio
    }
}
