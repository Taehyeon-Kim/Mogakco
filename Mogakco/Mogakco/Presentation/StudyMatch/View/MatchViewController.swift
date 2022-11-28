//
//  MatchViewController.swift
//  Mogakco
//
//  Created by taekki on 2022/11/28.
//

import UIKit

import SnapKit
import Then

final class MatchViewController: BaseViewController {
    
    private let pager = Pager()

    override func setHierarchy() {
        view.addSubview(pager)
    }
    
    override func setLayout() {
        pager.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func setAttributes() {
        view.backgroundColor = .systemBackground
        
        let viewControllers: [PageComponentProtocol] = [
            StudyRequestViewController(),
            StudyAcceptViewController()
        ]
        pager.setup(self, viewControllers: viewControllers)
    }
}
