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
    
    struct Input {
        let searchText: ControlProperty<String?>
        let editingDidEndOnExit: Observable<Void>
    }
    
    struct Output {
        let wantedList = BehaviorRelay<[String]>(value: [])
        let resultList = BehaviorRelay<[String]>(value: [])
        let ocurredError = PublishRelay<String>()
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.searchText.orEmpty
            .map { self.makeKeywordLists(with: $0) }
            .subscribe { list in
                output.wantedList.accept(list)
            }
            .disposed(by: disposeBag)
        
        input.editingDidEndOnExit
            .map {
                self.handle(
                    target: output.wantedList.value,
                    comparedWith: output.resultList.value
                )
            }
            .subscribe(onNext: { result in
                switch result {
                case .success(let data):
                    let prev = output.resultList.value
                    output.resultList.accept(data + prev)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
            .disposed(by: disposeBag)

        return output
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
}
