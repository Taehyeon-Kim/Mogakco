//
//  StudyRequestViewController.swift
//  Mogakco
//
//  Created by taekki on 2022/11/28.
//

import UIKit

final class StudyRequestViewController: BaseViewController, PageComponentProtocol {
    
    var pageTitle = "주변 새싹"
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    override func setAttributes() {
        collectionView.do {
            $0.register(ExpandableCardViewSectionHeader.self, ofKind: UICollectionView.elementKindSectionHeader)
            $0.register(ExpandableCardViewCell.self)
            $0.dataSource = self
            $0.delegate = self
            $0.collectionViewLayout = createLayout()
            $0.alwaysBounceVertical = false
            $0.contentInset = .init(top: 24, left: 0, bottom: 0, right: 0)
        }
    }
    
    override func setHierarchy() {
        view.addSubview(collectionView)
    }
    
    override func setLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(32))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(32))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        group.interItemSpacing = .fixed(8)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(194))
        let headerView = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 16, bottom: 24, trailing: 16)
        section.boundarySupplementaryItems = [headerView]
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension StudyRequestViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellType: ExpandableCardViewCell.self, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ExpandableCardViewCell else { return }
        cell.isExpanded.toggle()
        collectionView.performBatchUpdates(nil)
        view.layoutIfNeeded()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ExpandableCardViewSectionHeader.self, ofKind: kind, for: indexPath)
        return view
    }
}
