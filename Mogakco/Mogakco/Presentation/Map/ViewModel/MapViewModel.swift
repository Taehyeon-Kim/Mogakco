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
    private let location = PublishRelay<CLLocation>()
    
    init(locationManager: LocationManager) {
        self.locationManager = locationManager
    }
    
    struct Input {
        let viewDidAppear: Observable<Void>
        let locationButtonDidTap: Observable<Void>
        let centerLocation: BehaviorRelay<CLLocationCoordinate2D>
    }
    
    struct Output {
        let centerLocation = BehaviorRelay<CLLocation>(value: CLLocation())
        let shouldMoveCenter = BehaviorRelay<Bool>(value: true)
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.viewDidAppear
            .subscribe(with: self) { owner, _ in
                owner.locationManager.startUpdatingLocation()
                owner.requestLocation()
            }
            .disposed(by: disposeBag)
        
        input.locationButtonDidTap
            .map { true }
            .bind(to: output.shouldMoveCenter)
            .disposed(by: disposeBag)
        
        input.centerLocation
            .map { CLLocation(latitude: $0.latitude, longitude: $0.longitude) }
            .bind(to: output.centerLocation)
            .disposed(by: disposeBag)
        
        return output
    }
}

extension MapViewModel {
    
    func requestLocation() {
        locationManager.observeUpdatedLocation()
            .compactMap { $0.last }
            .subscribe(with: self) { owner, location in
                owner.location.accept(location)
            }
            .disposed(by: disposeBag)
    }
}
