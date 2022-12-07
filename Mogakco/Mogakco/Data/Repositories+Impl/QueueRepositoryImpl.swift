//
//  QueueRepositoryImpl.swift
//  Mogakco
//
//  Created by taekki on 2022/12/07.
//

import Foundation
import RxSwift

final class QueueRepositoryImpl: QueueRepository {
    
    private let disposeBag = DisposeBag()
    private let networkProvider: NetworkProvider
    
    init(
        networkProvider: NetworkProvider = NetworkProviderImpl()
    ) {
        self.networkProvider = networkProvider
    }
}

extension QueueRepositoryImpl {
    
    func fetchQueueList(
        lat: Double,
        long: Double,
        completion: @escaping (Result<SearchResponseDTO, Error>) -> Void
    ) {
        let searchAPI = SearchAPI(lat: lat, long: long)
        networkProvider.execute(of: searchAPI)
            .subscribe { response in
                switch response {
                case let .success(data):
                    completion(.success(data))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
            .disposed(by: disposeBag)
    }
}
