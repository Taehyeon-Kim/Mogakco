//
//  Onboarding.swift
//  Mogakco
//
//  Created by taekki on 2022/11/10.
//

import UIKit

struct Onboarding {
    let text: String
    let image: UIImage?
    
    static let data: [Onboarding] = [
        Onboarding(text: "위치 기반으로 빠르게\n주위 친구를 확인", image: .imgOnboarding1),
        Onboarding(text: "스터디를 원하는 친구를\n찾을 수 있어요", image: .imgOnboarding2),
        Onboarding(text: "SeSAC Study", image: .imgOnboarding3)
    ]
}
