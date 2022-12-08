//
//  KeywordViewModel.swift
//  Mogakco
//
//  Created by taekki on 2022/11/26.
//

import Foundation
import RxCocoa
import RxSwift

final class KeywordViewModel: ViewModelType {
    
    var disposeBag = DisposeBag()

    var items = BehaviorRelay<[KeywordViewSection]>(value: [.arounded([]), .wanted([])])
    
    let dataSource = KeywordDataSource.dataSource()
    var isSucceed = PublishRelay<Bool>()
    var isErrorOccured = PublishRelay<String>()

    private let searchStudyUseCase: SearchStudyUseCase    
    var searchParameter: SearchAPI
    
    init(
        searchParameter: SearchAPI,
        searchStudyUseCase: SearchStudyUseCase
    ) {
        self.searchParameter = searchParameter
        self.searchStudyUseCase = searchStudyUseCase
    }
    
    func transform(input: Input) -> Output {
        
        let searchResponseDTO = input.viewDidLoad
            .withUnretained(self)
            .flatMapLatest { owner, _ in
                let requestValue = SearchStudyUseCaseRequestValue(
                    lat: owner.searchParameter.lat,
                    long: owner.searchParameter.long)
                return owner.searchStudyUseCase.execute(requestValue: requestValue)
                    .map { owner.makeAroundedKeywords(with: $0) }
            }
            .asDriverOnErrorJustComplete()

        return Output(
            aroundedKeywords: searchResponseDTO
        )
    }
}

extension KeywordViewModel {
    struct Input {
        let viewDidLoad: Observable<Void>
        let searchText: ControlProperty<String?>
        let editingDidEndOnExit: Observable<Void>
        let searchButtonDidTap: Observable<Void>
    }
    
    struct Output {
        let wantedList = BehaviorRelay<[String]>(value: [])
        let resultList = BehaviorRelay<[String]>(value: [])
        let ocurredError = PublishRelay<String>()
        let isSucceed = PublishRelay<Bool>()
        let aroundedKeywords: Driver<[KeywordItemViewModel]>
    }
}

extension KeywordViewModel {
    
    private func makeKeywordLists(with text: String) -> [String] {
        /// [String] 반환
        /// cf) split 메서드 : [SubString] 반환
        return text.components(separatedBy: " ")
    }
    
    private func handle(target keywords: [String], comparedWith: [String]) -> Result<[String], KeywordError> {
        // 키워드 개수 체크
        if comparedWith.count + keywords.count > 8 {
            return .failure(KeywordError.outOfKeywordNumber)
        }
        
        // 키워드 글자 수 체크
        for keyword in keywords {
            if !(1...8).contains(keyword.count) {
                return .failure(KeywordError.outOfKeywordLength)
            }
            
            if comparedWith.contains(keyword) {
                return .failure(KeywordError.duplicated)
            }
        }
        
        return .success(keywords)
    }

    private func makeAroundedKeywords(with dto: SearchResponseDTO) -> [KeywordItemViewModel] {
        let fromRecommend = dto.fromRecommend.map { KeywordItemViewModel(contents: $0, keywordType: .recommended) }
        let fromQueueDB = dto.fromQueueDB.flatMap { $0.studylist.map { KeywordItemViewModel(contents: $0, keywordType: .arounded) } }
        let fromQueueDBRequested = dto.fromQueueDBRequested.flatMap { $0.studylist.map { KeywordItemViewModel(contents: $0, keywordType: .arounded) } }
        
        var results = fromRecommend + fromQueueDB + fromQueueDBRequested
        results = removeDuplicatedKeywords(items: results)

        items.accept([.arounded(results.map {.keyword($0)}), .wanted([])])
        return results
    }
    
    private func removeDuplicatedKeywords(items: [KeywordItemViewModel]) -> [KeywordItemViewModel] {
        var items = items
        items.removeAll { viewModel in
            viewModel.contents == "anything" ||
            viewModel.contents.isEmpty
        }
        
        let result = Array(Set(items))
        return result.sorted { first, _ in
            return first.keywordType == .recommended
        }
    }
}

struct KeywordItemViewModel: Equatable, Hashable {
    
    enum KeywordType {
        case recommended
        case arounded
        case wanted
    }
    
    let contents: String
    let keywordType: KeywordType
}

extension ObservableType {
    
    func catchErrorJustComplete() -> Observable<Element> {
        return `catch` { _ in
            return Observable.empty()
        }
    }
    
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            return Driver.empty()
        }
    }
    
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
}
