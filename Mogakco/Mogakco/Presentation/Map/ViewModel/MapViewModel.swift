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
    
    private let networkProvider: NetworkProvider
    private let locationManager: LocationManager
    
    private let location = PublishRelay<CLLocation>()
    private let authorization = PublishRelay<CLAuthorizationStatus>()
    private let queueStatue = BehaviorRelay<QueueState>(value: .general)
    
    init(
        networkProvider: NetworkProvider,
        locationManager: LocationManager
    ) {
        self.networkProvider = networkProvider
        self.locationManager = locationManager
    }
    
    struct Input {
        let viewDidAppear: Observable<Void>
        let locationButtonDidTap: Observable<Void>
        let centerLocation: BehaviorRelay<CLLocationCoordinate2D>
        let floatingButtonDidTap: Observable<Void>
    }
    
    struct Output {
        let centerLocation = BehaviorRelay<CLLocation>(value: CLLocation())
        let shouldMoveCenter = BehaviorRelay<Bool>(value: true)
        let isfloatingButtonSelected = PublishRelay<CLAuthorizationStatus>()
        let myQueueStatus = BehaviorRelay<QueueState>(value: .general)
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.viewDidAppear
            .subscribe(with: self) { owner, _ in
                owner.locationManager.startUpdatingLocation()
                owner.requestLocation()
                owner.checkMyQueueState()
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
        
        input.floatingButtonDidTap
            .withUnretained(self)
            .flatMap { owner, _ in owner.locationManager.observeAuthorization() }
            .subscribe(with: self) { owner, status in
                owner.authorization.accept(status)
            }
            .disposed(by: disposeBag)
        
        output.myQueueStatus
            .bind(to: queueStatue)
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
    
    func checkMyQueueState() {
        let myQueueStateAPI = MyQueueStateAPI()
        networkProvider.execute(of: myQueueStateAPI)
            .subscribe(with: self) { owner, queueStateDTO in
                if queueStateDTO.matched == 0 {
                    owner.queueStatue.accept(.waiting)
                } else if queueStateDTO.matched == 1 {
                    owner.queueStatue.accept(.matched)
                }
    
            } onFailure: { owner, error in
                owner.queueStatue.accept(.general)
            }
            .disposed(by: disposeBag)
    }
}
