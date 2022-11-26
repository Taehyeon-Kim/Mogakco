//
//  MyProfileItemCellViewModel.swift
//  Mogakco
//
//  Created by taekki on 2022/11/21.
//

import UIKit
import RxCocoa
import RxSwift

struct MyProfileItemCellViewModel {
    
    var iconImage: UIImage?
    var title: String
    var accessoryImage: UIImage?
    var isProfile: Bool
    
    init(
        iconImage: UIImage? = nil,
        title: String,
        accessoryImage: UIImage? = nil,
        isProfile: Bool = false
    ) {
        self.iconImage = iconImage
        self.title = title
        self.accessoryImage = accessoryImage
        self.isProfile = isProfile
    }
}
