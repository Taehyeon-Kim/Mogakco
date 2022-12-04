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

struct Pin {
    let lat: Double
    let long: Double
    let image: UIImage?
}

extension FromQueueDB {
    
    func asPin() -> Pin {
        let sesacFace = SeSACFace(rawValue: sesac)
        return Pin(lat: lat, long: long, image: sesacFace?.image)
    }
}

enum SeSACFace: Int {
    case face1, face2, face3, face4, face5
    
    var image: UIImage? {
        switch self {
        case .face1:
            return .imgSeSACFace1
        case .face2:
            return .imgSeSACFace2
        case .face3:
            return .imgSeSACFace3
        case .face4:
            return .imgSeSACFace4
        case .face5:
            return .imgSeSACFace5
        }
    }
}

protocol MapManager {
    func createPins(_ pins: [Pin])
    func clearPins()
    func moveUserLocation()
}

// 지도가 담당할 역할
// 1) 가운데 위치 지정
// 2) annotaion 표시
final class MapManagerImpl: NSObject {
    
    var mapView: MKMapView? {
        didSet {
            registerAnnotationViews()
            mapView?.delegate = self
        }
    }
    
    // MARK: Rx
    var disposeBag = DisposeBag()
    
    lazy var centerLocation = BehaviorRelay<CLLocationCoordinate2D>(value: defaultLocation)
    private let defaultLocation = CLLocationCoordinate2D(
        latitude: 37.517819364682694,
        longitude: 126.88647317074734
    )

    func drawPins(for studies: [FromQueueDB]) {
        for study in studies {
            let pin = MKPointAnnotation()
            pin.title = study.nick
            pin.coordinate = CLLocationCoordinate2D(latitude: study.lat, longitude: study.long)
            mapView?.addAnnotation(pin)
        }
    }
}

extension MapManagerImpl: MapManager {
    
    private func registerAnnotationViews() {
        mapView?.register(
            CustomAnnotationView.self,
            forAnnotationViewWithReuseIdentifier: NSStringFromClass(CustomAnnotationView.self)
        )
    }
    
    func createPins(_ pins: [Pin]) {
        for pin in pins {
            let coordinate = CLLocationCoordinate2D(latitude: pin.lat, longitude: pin.long)
            let annotation = CustomAnnotation(image: pin.image, coordinate: coordinate)
            mapView?.addAnnotation(annotation)
        }
    }
    
    func clearPins() {
        // guard let mapView = mapView else { return }
        // UIView.animate(withDuration: 0.15) {
        //     mapView.removeAnnotations(mapView.annotations)
        // }
        // mapView.layoutIfNeeded()
    }
    
    func moveUserLocation() {
        mapView?.setUserTrackingMode(.follow, animated: true)
        
        guard let userLocation = mapView?.userLocation.location else { return }
        mapView?.locateOnCenter(userLocation)
    }
    
    func observeUpdatedCenter() -> Observable<CLLocationCoordinate2D> {
        return PublishRelay<CLLocationCoordinate2D>.create { emitter in
            self.rx.methodInvoked(#selector(MKMapViewDelegate.mapView(_:regionDidChangeAnimated:)))
                .compactMap { $0.first as? MKMapView }
                .subscribe { mapView in
                    emitter.onNext(mapView.centerCoordinate)
                }
                .disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
}

extension MapManagerImpl: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation.isKind(of: CustomAnnotation.self) else { return nil }
        
        var annotationView: MKAnnotationView?
        
        if let annotation = annotation as? CustomAnnotation {
            annotationView = setupCustomAnnotationView(for: annotation, on: mapView)
        }
        
        return annotationView
    }
    
    func setupCustomAnnotationView(for annotation: CustomAnnotation, on mapView: MKMapView) -> MKAnnotationView {
        let customAnnotationView = mapView.dequeueReusableAnnotationView(
            withIdentifier: NSStringFromClass(CustomAnnotationView.self),
            for: annotation)
        customAnnotationView.annotation = annotation
        customAnnotationView.image = annotation.image?.resized(side: 80)
        return customAnnotationView
    }
    
    /// Responding to Map Position Changes
    /// regionDidChangeAnimated true : zoom in/out
    /// regionDidChangeAnimated false : move only
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {}
}

extension MKMapView {
    
    /// 단순히 중앙에 맞추고 싶으면
    /// centerCoordinate 값 변경 후에 setCenter 메서드 호출해도 될 듯
    /// 지금은 축척가지 고려해야하기 때문에 Region으로 설정
    func locateOnCenter(
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
