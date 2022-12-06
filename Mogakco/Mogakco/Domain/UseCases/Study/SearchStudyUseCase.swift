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
    func execute(requestValue: SearchStudyUseCaseRequestValue) -> Observable<SearchResponseDTO>
}

final class SearchStudyUseCaseImpl: SearchStudyUseCase {
    
    private let queueRepository: QueueRepository
    
    init(queueRepository: QueueRepository) {
        self.queueRepository = queueRepository
    }
    
    func execute(requestValue: SearchStudyUseCaseRequestValue) -> Observable<SearchResponseDTO> {
        return Observable.create { [weak self] emitter in
            
            self?.queueRepository.fetchQueueList(lat: requestValue.lat, long: requestValue.long) { response in
                switch response {
                case let .success(searchResponseDTO):
                    emitter.onNext(searchResponseDTO)
                case let .failure(error):
                    emitter.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}

struct SearchStudyUseCaseRequestValue {
    let lat: Double
    let long: Double
}
