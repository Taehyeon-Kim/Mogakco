//
//  MyInfoViewController.swift
//  Mogakco
//
//  Created by taekki on 2022/11/21.
//

import UIKit

import RxCocoa
import RxSwift
import RxDataSources

final class MyInfoViewController: BaseViewController {
    
    private let viewModel: MyInfoViewModel
    private let dataSource: RxCollectionViewSectionedReloadDataSource<MyInfoViewSection>
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    init(
        viewModel: MyInfoViewModel
    ) {
        self.viewModel = viewModel
        self.dataSource = Self.dataSourceFactory()
        super.init()
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    override func setAttributes() {
        self.do {
            $0.title = "내정보"
            $0.view.backgroundColor = .white
        }
        
        collectionView.do {
            $0.register(MyInfoItemCell.self)
            $0.alwaysBounceVertical = false
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
}

extension MyInfoViewController {
    
    private func createLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { section, _ -> NSCollectionLayoutSection? in
        
            switch section {
            case 0:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(97))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(97))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                
                return NSCollectionLayoutSection(group: group)
            case 1:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(75))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(75))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                
                return NSCollectionLayoutSection(group: group)
            default:
                return nil
            }
        }
        
        return layout
    }
    
    private static func dataSourceFactory() -> RxCollectionViewSectionedReloadDataSource<MyInfoViewSection> {
        return .init { _, collectionView, indexPath, sectionItem in
            let cell = collectionView.dequeueReusableCell(cellType: MyInfoItemCell.self, for: indexPath)
            
            switch sectionItem {
            case let .profile(viewModel):
                cell.configure(with: viewModel)
                
            case let .notice(viewModel):
                cell.configure(with: viewModel)
                
            case let .faq(viewModel):
                cell.configure(with: viewModel)
                
            case let .qna(viewModel):
                cell.configure(with: viewModel)
                
            case let .settingAlarm(viewModel):
                cell.configure(with: viewModel)
                
            case let .permit(viewModel):
                cell.configure(with: viewModel)
            }
            
            return cell
        }
    }
}

extension MyInfoViewController: Bindable {
    
    func bind() {
        viewModel.sections
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}
