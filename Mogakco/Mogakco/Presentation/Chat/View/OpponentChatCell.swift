//
//  OpponentChatCell.swift
//  Mogakco
//
//  Created by taekki on 2022/11/30.
//

import UIKit

final class OpponentChatCell: BaseCollectionViewCell {
    
    let containerView = UIView()
    let chatLabel = UILabel()
    let timeLabel = UILabel()
    
    override func setAttributes() {
        
        containerView.do {
            $0.backgroundColor = .MGC.whiteGreen
            $0.makeRounded(radius: 8)
        }
        
        chatLabel.do {
            $0.numberOfLines = 0
            $0.lineBreakMode = .byCharWrapping
            $0.text = "대단히 반갑습니다 상당히 고맙습니다 저는 새싹입니다"
            $0.textColor = .MGC.black
            $0.textAlignment = .left
            $0.font = .notoSansR(14)
            $0.setLineHeight(23.8)
        }
        
        timeLabel.do {
            $0.text = "15:02"
            $0.textColor = .MGC.gray6
            $0.font = .notoSansR(12)
        }
    }
    
    override func setHierarchy() {
        contentView.addSubviews(containerView, chatLabel, timeLabel)
    }
    
    override func setLayout() {
        chatLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(32)
            $0.leading.greaterThanOrEqualToSuperview().inset(111)
            $0.directionalVerticalEdges.equalToSuperview().inset(10)
        }
        
        containerView.snp.makeConstraints {
            $0.directionalVerticalEdges.equalTo(chatLabel).inset(-10)
            $0.directionalHorizontalEdges.equalTo(chatLabel).inset(-16)
        }
        
        timeLabel.snp.makeConstraints {
            $0.trailing.equalTo(containerView.snp.leading).offset(-8)
            $0.bottom.equalTo(containerView)
        }
    }
}

extension OpponentChatCell {
    
    func configure(with chat: String) {
        chatLabel.text = chat
    }
}
