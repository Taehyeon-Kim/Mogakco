//
//  KeywordView.swift
//  Mogakco
//
//  Created by taekki on 2022/11/26.
//

import UIKit

final class KeywordView: BaseView {
    
    lazy var backButton = UIButton()
    lazy var searchBar = UISearchBar()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    lazy var findButton = MGCButton(.fill)
    
    private let padding: CGFloat = 16
    private let buttonRadius: CGFloat = 8
    
    override func setHierarchy() {
        addSubviews(backButton, searchBar, collectionView, findButton)
    }
    
    override func setLayout() {
        backButton.snp.makeConstraints {
            $0.size.equalTo(24)
            $0.leading.equalTo(safeAreaLayoutGuide).inset(padding)
            $0.top.equalTo(safeAreaLayoutGuide).offset(16)
        }
        
        searchBar.snp.makeConstraints {
            $0.leading.equalTo(backButton.snp.trailing).offset(8)
            $0.centerY.equalTo(backButton)
            $0.trailing.equalTo(safeAreaLayoutGuide).inset(padding)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(32)
            $0.directionalHorizontalEdges.bottom.equalToSuperview()
        }
        
        findButton.snp.makeConstraints {
            $0.directionalHorizontalEdges.bottom.equalTo(safeAreaLayoutGuide).inset(padding)
            $0.height.equalTo(48)
        }
    }
    
    override func setAttributes() {
        backgroundColor = .MGC.white
        
        backButton.do {
            $0.setImage(.icnArrow, for: .normal)
        }
        
        searchBar.do {
            $0.placeholder = "띄어쓰기로 복수 입력이 가능해요"
            $0.backgroundImage = UIImage()
        }
        
        findButton.do {
            $0.title = "새싹 찾기"
            $0.makeRounded(radius: buttonRadius)
        }
        
        collectionView.do {
            $0.register(KeywordCell.self)
            $0.register(KeywordSectionHeaderView.self, ofKind: UICollectionView.elementKindSectionHeader)
            $0.dataSource = self
            $0.collectionViewLayout = createLayout()
        }
    }
}

extension KeywordView {
    
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(1), heightDimension: .estimated(32))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(32))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(8)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [createHeaderLayout()]
        section.interGroupSpacing = 8
        section.contentInsets = .init(top: 0, leading: 16, bottom: 24, trailing: 16)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func createHeaderLayout() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(18))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return header
    }
}

extension KeywordView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return KeywordViewSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellType: KeywordCell.self, for: indexPath)
        cell.sizeToFit()
        cell.configure(with: "Swift")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(KeywordSectionHeaderView.self, ofKind: kind, for: indexPath)
        view.configure(with: KeywordViewSection.allCases[indexPath.section].title)
        return view
    }
}
