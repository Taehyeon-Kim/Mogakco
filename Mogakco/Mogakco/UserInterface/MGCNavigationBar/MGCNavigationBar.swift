//
//  MGCNavigationBar.swift
//  Mogakco
//
//  Created by taekki on 2022/11/29.
//

import UIKit

import SnapKit
import Then

final class MGCNavigationBar: BaseView {
 
    let leftButton = UIButton()
    let titleLabel = UILabel()
    let deleteButton = UIButton()
    let rightButton = UIButton()
    
    private let navigationBarHeight: CGFloat = 44.0
    
    public enum BarItem {
        case back, more, close, add
        
        var image: UIImage? {
            switch self {
            case .back:     return .icnArrow
            case .more:     return .icnMore
            case .close:    return .icnCloseBig
            case .add:      return .icnFriendsPlus
            }
        }
    }
    
    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var rightTitle: String? {
        didSet { rightButton.setTitle(rightTitle, for: .normal) }
    }
    
    var leftBarItem: BarItem? {
        didSet { leftButton.setImage(leftBarItem?.image, for: .normal) }
    }
    
    var rightBarItem: BarItem? {
        didSet { rightButton.setImage(rightBarItem?.image, for: .normal) }
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: navigationBarHeight)
    }
    
    override func setAttributes() {
        titleLabel.do {
            $0.textColor = .MGC.black
            $0.font = .notoSansM(14)
        }
        
        rightButton.do {
            $0.setTitleColor(.MGC.black, for: .normal)
            $0.titleLabel?.font = .notoSansM(14)
        }
    }
    
    override func setHierarchy() {
        addSubviews(leftButton, titleLabel, rightButton)
    }
    
    override func setLayout() {
        leftButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        rightButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
}
