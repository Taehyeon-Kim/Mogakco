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
        let textDidBeginEditing: ControlEvent<Void>
    }
    
    struct Output {
        let wantedList = PublishRelay<[String]>()
        let textDidBeginEditing = PublishRelay<Void>()
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.searchText.orEmpty
            .flatMap { self.makeKeywordLists(with: $0) }
            .subscribe { list in
                output.wantedList.accept(list)
            }
            .disposed(by: disposeBag)
        
        input.textDidBeginEditing
            .bind(to: output.textDidBeginEditing)
            .disposed(by: disposeBag)
        
        return output
    }
}

extension KeywordViewModel {
    
    private func makeKeywordLists(with text: String) -> Observable<[String]> {
        
        if let char = text.last,
           char.isWhitespace {
            // validation
            valid()
        }
        
        return .just(["hhh", "aaa"])
    }
    
    private func valid() {
        
    }
}
