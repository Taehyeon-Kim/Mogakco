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
            centerLocation: mapManager.centerLocation
        )
        let output = viewModel.transform(input: input)
        
        output.centerLocation
            .bind(with: self) { `self`, location in
                self.mapManager.mapView?.centerToLocation(location)
            }
            .disposed(by: disposeBag)
    }
}
