//
//  ChatViewSectionHeaderView.swift
//  Mogakco
//
//  Created by taekki on 2022/11/30.
//

import UIKit

final class ChatViewSectionHeaderView: UICollectionReusableView {

    private let dateButton = UIButton()
    private lazy var notiStackView = UIStackView(arrangedSubviews: [iconImageView, titleLabel])
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    
    var dateString: String = "1월 15일 토요일"
    var chatUsername: String = "고래밥"
    var subTitle: String = "채팅을 통해 약속을 정해보세요 :)"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
        setAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {
        addSubviews(dateButton, notiStackView, subTitleLabel)
    }
    
    private func setLayout() {
        dateButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(114)
            $0.height.equalTo(28)
        }
        
        notiStackView.snp.makeConstraints {
            $0.top.equalTo(dateButton.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(notiStackView.snp.bottom).offset(2)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setAttributes() {
        dateButton.do {
            $0.setTitle(dateString, for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .notoSansM(12)
            $0.backgroundColor = .MGC.gray7
            $0.makeRounded(radius: 14)
        }
        
        notiStackView.do {
            $0.axis = .horizontal
        }
        
        iconImageView.do {
            $0.image = .icnBell
        }
        
        titleLabel.do {
            $0.font = .notoSansM(14)
            $0.text = "\(chatUsername)님과 매칭되었습니다"
            $0.textColor = .MGC.gray7
        }
        
        subTitleLabel.do {
            $0.font = .notoSansR(14)
            $0.text = subTitle
            $0.textColor = .MGC.gray6
        }
    }
}

// MARK: - Preview

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ChatViewSectionHeaderViewPreview: PreviewProvider {
    static var previews: some View {
        ChatViewSectionHeaderView().showPreview(.iPhone13Mini)
    }
}
#endif
