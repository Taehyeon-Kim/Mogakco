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
    private let queueStatus = BehaviorRelay<QueueState>(value: .general)
    
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
        let updatedLocation: Observable<CLLocationCoordinate2D>
    }
    
    struct Output {
        let centerLocation = BehaviorRelay<CLLocation>(value: CLLocation())
        let shouldMoveCenter = BehaviorRelay<Bool>(value: true)
        let isfloatingButtonSelected = PublishRelay<CLAuthorizationStatus>()
        let myQueueStatus = BehaviorRelay<QueueState>(value: .general)
        let pin = BehaviorRelay<[Pin]>(value: [])
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
        
        input.viewDidAppear
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .flatMap { self.searchQueue(lat: input.centerLocation.value.latitude, long: input.centerLocation.value.longitude) }
            .subscribe { output.pin.accept($0) }
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
        
        input.updatedLocation
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .flatMap { self.searchQueue(lat: $0.latitude, long: $0.longitude) }
            .subscribe { output.pin.accept($0) }
            .disposed(by: disposeBag)
        
        output.myQueueStatus
            .bind(to: queueStatus)
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
                    owner.queueStatus.accept(.waiting)
                } else if queueStateDTO.matched == 1 {
                    owner.queueStatus.accept(.matched)
                }
    
            } onFailure: { owner, _ in
                owner.queueStatus.accept(.general)
            }
            .disposed(by: disposeBag)
    }
    
    func searchQueue(lat: Double, long: Double) -> Observable<[Pin]> {
        return PublishRelay<[Pin]>.create { emitter in
            let searchQueueAPI = SearchAPI(lat: lat, long: long)
            self.networkProvider.execute(of: searchQueueAPI)
                .subscribe { searchResponseDTO in
                    print("찾은 Response", searchResponseDTO)
                    emitter.onNext(searchResponseDTO.fromQueueDB.map { $0.asPin() })
                } onFailure: { error in
                    print("에러", error.localizedDescription)
                }
                .disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
}
