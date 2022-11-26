//
//  OnboardingView.swift
//  Mogakco
//
//  Created by taekki on 2022/11/10.
//

import UIKit

final class OnboardingView: BaseView {
    
    private enum Metric {
        static let collectionViewHeight = 564.adjustedHeight
        static let confirmButtonHeight = 48
        static let sideMargin = 10.adjustedWidth
        static let pageControlBottomMargin = -42.adjustedHeight
        static let pageControlHeight = 8.adjustedHeight
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())
    private let pageControl = UIPageControl()
    private let confirmButton = MGCButton(.fill)

    override func setAttributes() {
        backgroundColor = .MGC.white
        
        collectionView.do {
            $0.alwaysBounceVertical = false
            $0.dataSource = self
            $0.register(OnboardingCollectionViewCell.self)
        }
        
        pageControl.do {
            $0.numberOfPages = 3
            $0.currentPageIndicatorTintColor = .MGC.black
            $0.pageIndicatorTintColor = .MGC.gray5
        }
        
        confirmButton.do {
            $0.title = "시작하기"
        }
    }
    
    override func setHierarchy() {
        addSubview(collectionView)
        addSubview(pageControl)
        addSubview(confirmButton)
    }
    
    override func setLayout() {
        collectionView.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(Metric.collectionViewHeight)
        }

        confirmButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(Metric.sideMargin)
            $0.height.equalTo(Metric.confirmButtonHeight)
            $0.directionalHorizontalEdges.equalToSuperview().inset(Metric.sideMargin)
        }
        
        pageControl.snp.makeConstraints {
            $0.bottom.equalTo(confirmButton.snp.top).offset(Metric.pageControlBottomMargin)
            $0.height.equalTo(Metric.pageControlHeight)
            $0.centerX.equalToSuperview()
        }
    }
}

extension OnboardingView: UICollectionViewDataSource {
    
    func generateLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        // 스크롤 Delegate 효과
        section.visibleItemsInvalidationHandler = { [weak self] _, offset, env in
            let index = Int((offset.x / env.container.contentSize.width))
            self?.pageControl.currentPage = index
        }

        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Onboarding.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellType: OnboardingCollectionViewCell.self, for: indexPath)
        cell.configure(with: Onboarding.data[indexPath.row])
        return cell
    }
}
