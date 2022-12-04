//
//  CustomAnnotation.swift
//  Mogakco
//
//  Created by taekki on 2022/12/04.
//

import UIKit
import MapKit

/// 데이터는 MKAnnotation 프로토콜을 준수해야 함
/// coordinate 필수 프로퍼티를 구현해야 함
///
/// 새롭게 프로토콜을 채택해서 구현하는 이유는 image 데이터가 추가되기 때문
final class CustomAnnotation: NSObject, MKAnnotation {
    
    @objc dynamic var coordinate: CLLocationCoordinate2D
    var image: UIImage?
    
    init(image: UIImage? = nil, coordinate: CLLocationCoordinate2D) {
        self.image = image
        self.coordinate = coordinate
    }
}
