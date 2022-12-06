//
//  SearchStudyUseCase.swift
//  Mogakco
//
//  Created by taekki on 2022/12/07.
//

import Foundation
import RxSwift

// 스터디 입력 화면 유즈케이스
// - SearchResponseDTO 이후 더 컴팩트한 Domain Object로 변환하기
protocol SearchStudyUseCase {
    func execute() -> Observable<[SearchResponseDTO]>
}

final class SearchStudyUseCaseImpl: SearchStudyUseCase {
    
    func execute() -> Observable<[SearchResponseDTO]> {
        
    }
}
