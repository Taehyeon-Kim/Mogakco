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

protocol LocationManager {
    var locationManager: CLLocationManager? { get }
    
    func startUpdatingLocation()
    func stopUpdatingLocation()
    func requestAuthorization()
    func observeAuthorization() -> Observable<CLAuthorizationStatus>
    func observeUpdatedLocation() -> Observable<[CLLocation]>
}

final class LocationManagerImpl: NSObject, LocationManager {
    
    // MARK: Property
    var locationManager: CLLocationManager?
    var authorizationStatus = BehaviorRelay<CLAuthorizationStatus>(value: .notDetermined)
    
    // MARK: Rx
    var disposeBag = DisposeBag()
    
    override init() {
        super.init()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.distanceFilter = CLLocationDistance(3)
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
    }
}

extension LocationManagerImpl {
    
    /// 사용자 위치 업데이트 시작
    func startUpdatingLocation() {
        locationManager?.startUpdatingLocation()
    }
    
    /// 사용자 위치 업데이트 중단
    func stopUpdatingLocation() {
        locationManager?.stopUpdatingLocation()
    }
    
    /// 권한 요청
    func requestAuthorization() {
        locationManager?.requestWhenInUseAuthorization()
    }
    
    /// 권한 관찰
    func observeAuthorization() -> Observable<CLAuthorizationStatus> {
        return authorizationStatus.asObservable()
    }
    
    /// 위치 업데이트 상황을 옵저버블로 실시간 방출
    /// delegate 메소드 invoked
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
