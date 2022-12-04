//
//  QueueState.swift
//  Mogakco
//
//  Created by taekki on 2022/12/05.
//

import UIKit

enum QueueState {
    case general    // 201
    case waiting    // 200, matched 0
    case matched
    // case dodged, reviewed -> general(매칭 종료)
    
    var image: UIImage? {
        switch self {
        case .general:
            return .icnSearch?.resized(side: 40).withTintColor(.white)
        case .waiting:
            return .icnAntenna?.resized(side: 40).withTintColor(.white)
        case .matched:
            return .icnMessage?.resized(side: 40).withTintColor(.white)
        }
    }
}
