//
//  LocationManager.swift
//  Mogakco
//
//  Created by taekki on 2022/11/24.
//

import CoreLocation
import Foundation

import RxCocoa
import RxSwift

protocol LocationManager: AnyObject {
    
}

final class LocationManagerImpl: NSObject, LocationManager {
    
    var locationManager: CLLocationManager?
    var disposeBag = DisposeBag()
    var authorizationStatus = BehaviorRelay<CLAuthorizationStatus>(value: .notDetermined)
    
    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager?.distanceFilter = CLLocationDistance(3)
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
    }
}

extension LocationManagerImpl {
    
    func start() {
        locationManager?.startUpdatingLocation()
    }
    
    func stop() {
        locationManager?.stopUpdatingLocation()
    }
    
    func requestAuthorization() {
        locationManager?.requestWhenInUseAuthorization()
    }
    
    func observeAuthorization() -> Observable<CLAuthorizationStatus> {
        return authorizationStatus.asObservable()
    }
    
    func observeUpdatedLocation() -> Observable<[CLLocation]> {
        return PublishRelay<[CLLocation]>.create({ emitter in
            self.rx.methodInvoked(#selector(CLLocationManagerDelegate.locationManager(_:didUpdateLocations:)))
                .compactMap({ $0.last as? [CLLocation] })
                .subscribe(onNext: { location in
                    emitter.onNext(location)
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        })
    }
}

extension LocationManagerImpl: CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]) {}
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorizationStatus.accept(status)
    }
}
