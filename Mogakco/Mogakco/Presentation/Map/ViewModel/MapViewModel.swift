//
//  MapViewModel.swift
//  Mogakco
//
//  Created by taekki on 2022/11/24.
//

import CoreLocation

import RxCocoa
import RxSwift

final class MapViewModel: ViewModelType {

    private var disposeBag = DisposeBag()
    private let locationManager: LocationManager
    
    init(locationManager: LocationManager = LocationManagerImpl()) {
        self.locationManager = locationManager
    }
    
    struct Input {
        let centerLocation: BehaviorRelay<CLLocationCoordinate2D>
    }
    
    struct Output {
        let centerLocation = BehaviorRelay<CLLocation>(value: CLLocation())
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.centerLocation
            .map { CLLocation(latitude: $0.latitude, longitude: $0.longitude) }
            .bind(to: output.centerLocation)
            .disposed(by: disposeBag)
        
        return output
    }
}
