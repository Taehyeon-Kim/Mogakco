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
    
    private let pager = Pager()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // PopUp을 Window에 추가해주고 있기 때문에
    // 뷰가 완전히 로드된 이후에 띄워주어야 한다.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        MGCPopUp.shared
            .setType(.cancelStudy)
            .present { type in
            switch type {
            case .cancel:
                print("")
                // 취소 액션
                
            case .confirm:
                print("")
                // 확인 액션
            }
        }
    }
    
    override func setHierarchy() {
        view.addSubviews(pager)
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
