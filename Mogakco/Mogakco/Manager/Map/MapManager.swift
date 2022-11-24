//
//  MapManager.swift
//  Mogakco
//
//  Created by taekki on 2022/11/24.
//

import Foundation
import MapKit

import RxCocoa
import RxSwift

protocol MapManager: AnyObject {
    
}

final class MapManagerImpl: NSObject, MapManager {
    
    var mapView: MKMapView?
    
    lazy var centerLocation = BehaviorRelay<CLLocationCoordinate2D>(value: defaultLocation)
    private let defaultLocation = CLLocationCoordinate2D(
        latitude: 37.517819364682694,
        longitude: 126.88647317074734
    )
}

extension MKMapView {
    
    func centerToLocation(
        _ location: CLLocation,
        regionRadius: CLLocationDistance = 700
    ) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius
        )
        setRegion(coordinateRegion, animated: true)
    }
}
