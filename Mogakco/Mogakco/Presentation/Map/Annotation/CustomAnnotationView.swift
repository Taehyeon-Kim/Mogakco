//
//  CustomAnnotationView.swift
//  Mogakco
//
//  Created by taekki on 2022/12/04.
//

import UIKit
import MapKit

import SnapKit
import Then

final class CustomAnnotationView: MKAnnotationView {

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        // if let annotation = annotation as? CustomAnnotation {
        //     self.image = annotation.image
        // }
        
        configure()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
        backgroundColor = .clear
    }
}
