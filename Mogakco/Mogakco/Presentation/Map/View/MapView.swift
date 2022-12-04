//
//  MapView.swift
//  Mogakco
//
//  Created by taekki on 2022/11/24.
//

import MapKit
import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class MapView: BaseView {
    
    lazy var mapView = MKMapView()
    lazy var centerMarker = UIImageView()
    let genderFilterView = GenderFilterView()
    lazy var locationButton = UIButton()
    lazy var floatingButton = UIButton()
    
    override func setHierarchy() {
        addSubviews(
            mapView,
            centerMarker,
            genderFilterView,
            locationButton,
            floatingButton
        )
    }
    
    override func setLayout() {
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        centerMarker.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(48)
        }
        
        genderFilterView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(52)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(48)
            $0.height.equalTo(144)
        }
        
        locationButton.snp.makeConstraints {
            $0.top.equalTo(genderFilterView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.size.equalTo(48)
        }
        
        floatingButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(16)
            $0.size.equalTo(64)
        }
    }
    
    override func setAttributes() {
        mapView.do {
            $0.showsUserLocation = true
            $0.userTrackingMode = .follow
        }
        
        centerMarker.do {
            $0.image = .icnMapMarker
        }
        
        locationButton.do {
            $0.setImage(.icnPlace, for: .normal)
            $0.backgroundColor = .MGC.white
            $0.layer.cornerRadius = 8
        }
        
        floatingButton.do {
            $0.setImage(.icnSearch?.resized(side: 40).withTintColor(.white), for: .normal)
            $0.backgroundColor = .MGC.black
            $0.layer.cornerRadius = 32
        }
    }
}
