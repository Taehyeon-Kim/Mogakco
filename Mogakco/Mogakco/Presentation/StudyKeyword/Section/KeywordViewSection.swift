//
//  KeywordViewSection.swift
//  Mogakco
//
//  Created by taekki on 2022/11/26.
//

import UIKit
import RxDataSources

enum KeywordViewSectionItem {
    case keyword(KeywordItemViewModel)
}

enum KeywordViewSection {
    case arounded([KeywordViewSectionItem])
    case wanted([KeywordViewSectionItem])
}

extension KeywordViewSection: SectionModelType {
    
    var title: String {
        switch self {
        case .arounded:
            return "지금 주변에는"
        case .wanted:
            return "내가 하고 싶은"
        }
    }

    var items: [KeywordViewSectionItem] {
        switch self {
        case .arounded(let items):
            return items
        case .wanted(let items):
            return items
        }
    }
    
    init(original: KeywordViewSection, items: [KeywordViewSectionItem]) {
        switch original {
        case .arounded:
            self = .arounded(items)
        case .wanted:
            self = .wanted(items)
        }
    }
}

struct KeywordDataSource {
    typealias DataSource = RxCollectionViewSectionedReloadDataSource
    
    static func dataSource() -> DataSource<KeywordViewSection> {
        return .init { dataSource, collectionView, indexPath, item -> UICollectionViewCell in
            
            switch dataSource[indexPath] {
            case let .keyword(viewModel):
                let cell = collectionView.dequeueReusableCell(cellType: KeywordCell.self, for: indexPath)
                cell.viewModel = viewModel
                return cell
            }
        }
    }
}
