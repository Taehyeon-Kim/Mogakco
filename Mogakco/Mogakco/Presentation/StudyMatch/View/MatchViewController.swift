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
    
    enum Literal {
        static let popUpTitle = "스터디를 취소하겠습니까?"
        static let popUpDesc = """
        스터디를 취소하시면 패널티가 부과됩니다
        """
    }
    
    private let navigationBar = MGCNavigationBar()
    private let pager = Pager()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setHierarchy() {
        view.addSubviews(navigationBar, pager)
    }
    
    override func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.directionalHorizontalEdges.equalToSuperview()
        }
        
        pager.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.directionalHorizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func setAttributes() {
        view.backgroundColor = .systemBackground
        
        navigationBar.do {
            $0.title = "새싹찾기"
            $0.leftBarItem = .back
            $0.rightTitle = "찾기중단"
        }
        
        let viewControllers: [PageComponentProtocol] = [
            StudyRequestViewController(),
            StudyAcceptViewController()
        ]
        pager.setup(self, viewControllers: viewControllers)
    }
}
