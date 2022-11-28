//
//  MGCPopUp.swift
//  Mogakco
//
//  Created by taekki on 2022/11/28.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class MGCPopUp: BaseView {
    
    typealias EventHandler = ((_ type: EventType) -> Void)
    
    // MARK: Property
    static let shared = MGCPopUp()
    
    private let disposeBag = DisposeBag()
    private var eventHandler: EventHandler?
    
    // MARK: Type
    enum EventType {
        case cancel
        case confirm
    }

    // MARK: UI
    private let dimmedView = UIView()
    private let containerView = UIView()
    
    private let contentsStack = UIStackView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    private let buttonStack = UIStackView()
    private let cancelButton = MGCButton(.cancel)
    private let confirmButton = MGCButton(.fill)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bind()
    }

    // MARK: Override method
    override func setAttributes() {
        dimmedView.do {
            $0.backgroundColor = .MGC.black
            $0.alpha = 0.5
        }
        
        containerView.do {
            $0.backgroundColor = .MGC.white
            $0.makeRounded(radius: 16)
        }
        
        contentsStack.do {
            $0.axis = .vertical
            $0.distribution = .fill
        }
        
        titleLabel.do {
            // $0.text = "스터디를 요청할게요!"
            $0.font = .notoSansM(16)
            $0.setLineHeight(29.6)
            $0.textColor = .MGC.black
            $0.textAlignment = .center
        }

        descriptionLabel.do {
            // $0.text = """
            // 상대방이 요청을 수락하면
            // 채팅창에서 대화를 나눌 수 있어요
            // """
            $0.font = .notoSansR(14)
            $0.setLineHeight(22.4)
            $0.textAlignment = .center
            $0.textColor = .MGC.gray7
            $0.numberOfLines = 0
        }
        
        cancelButton.do {
            $0.title = "취소"
        }
        
        confirmButton.do {
            $0.title = "확인"
        }
        
        buttonStack.do {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.spacing = 8
        }
    }
    
    override func setHierarchy() {
        addSubviews(dimmedView, containerView)
        contentsStack.addArrangedSubview(descriptionLabel)
        buttonStack.addArrangedSubviews(cancelButton, confirmButton)
        containerView.addSubviews(titleLabel, contentsStack, buttonStack)
    }
    
    override func setLayout() {
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.height.greaterThanOrEqualTo(156)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(30)
        }
        
        buttonStack.snp.makeConstraints {
            $0.bottom.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
        
        contentsStack.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.bottom.equalTo(buttonStack.snp.top).offset(-16)
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
        }
    }
}

// MARK: Setup UI
extension MGCPopUp {
    
    func setTitle(_ title: String) -> Self {
        self.titleLabel.text = title
        return self
    }
    
    func setDescription(_ description: String) -> Self {
        self.descriptionLabel.text = description
        return self
    }
    
    func setType(_ type: PopUpType) -> Self {
        titleLabel.text = type.title
        descriptionLabel.text = type.desc
        return self
    }
}

// MARK: Animation
extension MGCPopUp {
    
    // PopUp show
    func present(_ handler: @escaping EventHandler) {
        self.eventHandler = handler
        
        DispatchQueue.main.async {
            if let window = UIApplication.shared.connectedScenes
                .filter({ $0.activationState == .foregroundActive })
                .map({ $0 as? UIWindowScene })
                .compactMap({ $0 })
                .first?.windows
                .filter({$0.isKeyWindow}).first {
                self.frame = window.bounds
                window.addSubview(self)
            }
        }
    }
    
    private func closeView(_ type: EventType) {
        eventHandler?(type)
        remove()
    }
    
    // 뷰 스택에서 PopUp 완전히 제거
    private func remove() {
        UIView.animate(withDuration: 0.15) {
            self.alpha = 0
            self.containerView.alpha = 0
        } completion: { _ in
            self.removeFromSuperview()
        }
    }
    
    func bind() {
        cancelButton.button.rx.tap
            .bind(with: self) { owner, _ in owner.closeView(.cancel) }
            .disposed(by: disposeBag)
        
        confirmButton.button.rx.tap
            .bind(with: self) { owner, _ in owner.closeView(.confirm) }
            .disposed(by: disposeBag)
    }
}

extension MGCPopUp {
    
    enum PopUpType {
        case requestStudy
        case acceptStudy
        case cancelStudy
        case addFriend
        
        var title: String {
            switch self {
            case .requestStudy:
                return "스터디를 요청할게요!"
            case .acceptStudy:
                return "스터디를 수락할까요?"
            case .cancelStudy:
                return "스터디를 취소하겠습니까?"
            case .addFriend:
                return "고래밥님을 친구 목록에 추가할까요?"
            }
        }
        
        var desc: String {
            switch self {
            case .requestStudy:
                return """
                상대방이 요청을 수락하면
                채팅창에서 대화를 나눌 수 있어요
                """
            case .acceptStudy:
                return "요청을 수락하면 채팅창에서 대화를 나눌 수 있어요"
            case .cancelStudy:
                return "스터디를 취소하시면 패널티가 부과됩니다"
            case .addFriend:
                return "친구 목록에 추가하면 언제든지 채팅을 할 수 있어요"
            }
        }
    }
}
