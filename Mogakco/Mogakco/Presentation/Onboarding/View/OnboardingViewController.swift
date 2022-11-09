//
//  OnboardingViewController.swift
//  Mogakco
//
//  Created by taekki on 2022/11/07.
//

import UIKit

final class OnboardingViewController: BaseViewController {

    private enum Metric {
        static let collectionViewHeight = 564.adjustedHeight
        static let confirmButtonHeight = 48
        static let sideMargin = 10.adjustedWidth
        static let pageControlBottomMargin = -42.adjustedHeight
        static let pageControlHeight = 8.adjustedHeight
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())
    private let pageControl = UIPageControl()
    private let confirmButton = SSButton(.fill)

    override func setAttributes() {
        view.backgroundColor = .Gray.white
        
        collectionView.do {
            $0.alwaysBounceVertical = false
            $0.dataSource = self
            $0.register(OnboardingCollectionViewCell.self)
        }
        
        pageControl.do {
            $0.numberOfPages = 3
            $0.currentPageIndicatorTintColor = .Gray.black
            $0.pageIndicatorTintColor = .Gray.gray5
        }
        
        confirmButton.do {
            $0.title = "시작하기"
        }
    }
    
    override func setHierarchy() {
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(confirmButton)
    }
    
    override func setLayout() {
        collectionView.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(Metric.collectionViewHeight)
        }

        confirmButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(Metric.sideMargin)
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

extension OnboardingViewController: UICollectionViewDataSource {
    
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
