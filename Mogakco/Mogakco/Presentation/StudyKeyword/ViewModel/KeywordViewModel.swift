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
    
    var isSucceed = PublishRelay<Bool>()
    var isErrorOccured = PublishRelay<String>()
    
    struct Input {
        let searchText: ControlProperty<String?>
        let editingDidEndOnExit: Observable<Void>
        let searchButtonDidTap: Observable<Void>
    }
    
    struct Output {
        let wantedList = BehaviorRelay<[String]>(value: [])
        let resultList = BehaviorRelay<[String]>(value: [])
        let ocurredError = PublishRelay<String>()
        let isSucceed = PublishRelay<Bool>()
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
        
        input.searchButtonDidTap
            .asDriver(onErrorJustReturn: ())
            .map { self.findQueue() }
            .drive()
            .disposed(by: disposeBag)
        
        isSucceed
            .bind(to: output.isSucceed)
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
    
    private func findQueue() {
        let findQueueAPI = FindQueueAPI(
            long: 126.92983890550006,
            lat: 37.482733667903865,
            studylist: ["anything"]
        )
        
        NetworkProviderImpl().execute(of: findQueueAPI)
            .subscribe { _ in
                print("성공")
                self.isSucceed.accept(true)
            } onFailure: { error in
                print("실패")
                self.isErrorOccured.accept(error.localizedDescription)
            }
            .disposed(by: disposeBag)
    }
}
