//
//  ChatView.swift
//  Mogakco
//
//  Created by taekki on 2022/11/30.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class ChatView: BaseView {
    
    let navigationBar = MGCNavigationBar()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    let chatInputContainerView = UIView()
    let chatInputView = ChatInputView()
    
    override func setAttributes() {
        backgroundColor = .MGC.white
        
        navigationBar.do {
            $0.leftBarItem = .back
            $0.title = "유저명"
            $0.rightBarItem = .more
        }
        
        collectionView.do {
            $0.dataSource = self
            $0.register(MyChatCell.self)
            $0.register(OpponentChatCell.self)
            $0.register(ChatViewSectionHeaderView.self, ofKind: UICollectionView.elementKindSectionHeader)
        }
        
        chatInputContainerView.do {
            $0.backgroundColor = .MGC.white
        }
        
        chatInputView.do {
            $0.backgroundColor = .MGC.gray1
            $0.makeRounded(radius: 8)
        }
    }
    
    override func setHierarchy() {
        addSubviews(navigationBar, collectionView, chatInputContainerView, chatInputView)
    }
    
    override func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        chatInputContainerView.snp.makeConstraints {
            $0.directionalHorizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(76)
        }
        
        chatInputView.snp.makeConstraints {
            $0.directionalHorizontalEdges.bottom.equalTo(safeAreaLayoutGuide).inset(16)
            $0.height.greaterThanOrEqualTo(52)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.directionalHorizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}

extension ChatView {
    
    private func createLayout() -> UICollectionViewLayout {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(128))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(68))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 24
        section.boundarySupplementaryItems = [header]
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension ChatView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row.isMultiple(of: 2) {
            let cell = collectionView.dequeueReusableCell(cellType: MyChatCell.self, for: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(cellType: OpponentChatCell.self, for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ChatViewSectionHeaderView.self, ofKind: kind, for: indexPath)
        return view
    }
}
