//
//  ExpandableCardViewCell.swift
//  Mogakco
//
//  Created by taekki on 2022/11/29.
//

import UIKit

final class ExpandableCardViewCell: BaseCollectionViewCell {
    
    enum StudySection: Int, CaseIterable {
        case reputation
        case study
        case review
        
        var title: String {
            switch self {
            case .reputation: return "새싹 타이틀"
            case .study: return "하고 싶은 스터디"
            case .review: return "새싹 리뷰"
            }
        }
        
        var items: Int {
            switch self {
            case .reputation: return 6
            case .study: return 12
            case .review: return 1
            }
        }
    }

    let titleBackgroundView = UIView()
    let titleLabel = UILabel()
    let disclosureIndicator = UIImageView()
    let contentStackView = UIStackView()
    lazy var collectionView = DynamicHeightCollectionView(
        frame: .zero, collectionViewLayout: createLayout()
    )

    var isExpanded: Bool = false {
        didSet {
            setCollectionViewHeight()
            collectionView.isHidden = !isExpanded
        }
    }
    
    override func setAttributes() {
        layer.borderColor = UIColor.MGC.gray2.cgColor
        layer.borderWidth = 1.0
        makeRounded(radius: 8)

        titleLabel.do {
            $0.text = "타이틀"
            $0.textColor = .MGC.black
            $0.font = .notoSansM(16)
        }
        
        disclosureIndicator.do {
            $0.image = .icnMoreArrow
        }
        
        contentStackView.do {
            $0.axis = .vertical
            $0.distribution = .fillProportionally
        }
        
        collectionView.do {
            $0.isHidden = !isExpanded
            $0.alwaysBounceVertical = false
            $0.isScrollEnabled = false
            $0.showsVerticalScrollIndicator = false
            setCollectionView()
        }
    }
    
    override func setHierarchy() {
        titleBackgroundView.addSubviews(titleLabel, disclosureIndicator)
        contentStackView.addArrangedSubviews(titleBackgroundView, collectionView)
        contentView.addSubviews(contentStackView)
    }
    
    override func setLayout() {
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.directionalHorizontalEdges.bottom.equalToSuperview()
        }
        
        titleBackgroundView.snp.makeConstraints {
            $0.height.equalTo(58)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleBackgroundView.snp.bottom)
            $0.height.equalTo(500)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
        }
        
        disclosureIndicator.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalTo(titleLabel.snp.centerY)
        }
    }
    
    private func setCollectionViewHeight() {
        collectionView.snp.updateConstraints {
            $0.height.equalTo(collectionView.intrinsicContentSize.height)
        }
        layoutIfNeeded()
    }
}

extension ExpandableCardViewCell {
    
    private func setCollectionView() {
        collectionView.dataSource = self
        collectionView.register(
            ExpandableCardViewItemSectionHeader.self,
            ofKind: UICollectionView.elementKindSectionHeader
        )
        collectionView.register(ExpandableCardViewItemCell.self)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { section, _ -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(1), heightDimension: .estimated(32))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(34))
            let headerView = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            
            guard let section = StudySection(rawValue: section) else { return nil }
            
            switch section {
            case .reputation:
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(32))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
                group.interItemSpacing = .fixed(8)
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [headerView]
                section.contentInsets = .init(top: 0, leading: 16, bottom: 24, trailing: 16)
                return section
                
            case .study:
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(32))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.interItemSpacing = .fixed(8)
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [headerView]
                section.contentInsets = .init(top: 0, leading: 16, bottom: 24, trailing: 16)
                return section
                
            case .review:
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(32))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
                group.interItemSpacing = .fixed(8)
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [headerView]
                section.contentInsets = .init(top: 0, leading: 16, bottom: 16, trailing: 16)
                return section
            }
        }
    }
}

extension ExpandableCardViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return StudySection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return StudySection.allCases[section].items
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellType: ExpandableCardViewItemCell.self, for: indexPath)
        cell.sizeToFit()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ExpandableCardViewItemSectionHeader.self, ofKind: kind, for: indexPath)
        let section = StudySection.allCases
        view.setTitle(section[indexPath.section].title)
        return view
    }
}

final class DynamicHeightCollectionView: UICollectionView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
