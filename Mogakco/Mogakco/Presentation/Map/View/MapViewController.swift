//
//  MapViewController.swift
//  Mogakco
//
//  Created by taekki on 2022/11/24.
//

import UIKit
import CoreLocation

final class MapViewController: BaseViewController {
    
    private let rootView = MapView()
    private let viewModel: MapViewModel
    
    private lazy var mapManager = MapManagerImpl().then {
        $0.mapView = rootView.mapView
    }
    
    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
    }
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
}

extension MapViewController: Bindable {
    
    func bind() {
        let input = MapViewModel.Input(
            viewDidAppear: self.rx.methodInvoked(#selector(viewDidAppear)).map { _ in }.asObservable(),
            locationButtonDidTap: rootView.locationButton.rx.tap.asObservable(),
            centerLocation: mapManager.centerLocation,
            floatingButtonDidTap: rootView.floatingButton.rx.tap.asObservable(),
            updatedLocation: mapManager.observeUpdatedCenter()
        )
        let output = viewModel.transform(input: input)
  
        output.shouldMoveCenter
            .bind(with: self) { owner, _ in
                owner.mapManager.moveUserLocation()
            }
            .disposed(by: disposeBag)
        
        output.centerLocation
            .bind(with: self) { owner, location in
                owner.mapManager.mapView?.locateOnCenter(location)
            }
            .disposed(by: disposeBag)
        
        output.myQueueStatus
            .asDriver()
            .drive(with: self) { owner, state in
                print("🐙", state)
                owner.rootView.floatingButton.setImage(state.image, for: .normal)
            }
            .disposed(by: disposeBag)
        
        output.pin
            .bind(with: self) { owner, pins in
                print(pins)
                owner.mapManager.createPins(pins)
            }
            .disposed(by: disposeBag)
        
        output.isfloatingButtonSelected
            .asDriver(onErrorJustReturn: .notDetermined)
            .drive { status in
                switch status {
                case .notDetermined:
                    print("권한 없음")
                default:
                    print("화면 전환")
                    
                    let repository = QueueRepositoryImpl()
                    let useCase = SearchStudyUseCaseImpl(queueRepository: repository)
                    let parameter = SearchAPI(lat: 37.517819364682694, long: 126.88647317074734)
                    let viewModel = KeywordViewModel(searchParameter: parameter, searchStudyUseCase: useCase)
                    let viewController = KeywordViewController(viewModel: viewModel)
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
            }
            .disposed(by: disposeBag)
    }
}
