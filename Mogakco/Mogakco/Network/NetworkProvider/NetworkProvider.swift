//
//  NetworkProvider.swift
//  Mogakco
//
//  Created by taekki on 2022/11/18.
//

import Foundation
import RxSwift

protocol NetworkProvider: AnyObject {
    func execute<Endpoint: URLRequestable>(
        of endpoint: Endpoint
    ) -> Single<Endpoint.Response>
}

/// https://velog.io/@yy0867/Swift-%EC%A0%95%EB%A6%AC-URLSession-Combine
/// https://stackoverflow.com/questions/46833056/pattern-for-retrying-urlsession-datatask
/// https://github.com/Moya/Moya/issues/1402
/// 실제 Request를 수행하는 클래스
final class NetworkProviderImpl: NetworkProvider {

    private let session: URLSession
    private let authManager: AuthManager
    
    init(
        session: URLSession = .shared,
        authManager: any AuthManager = AuthManagerImpl()
    ) {
        self.session = session
        self.authManager = authManager
    }
    
    func execute<Endpoint: URLRequestable>(
        of endpoint: Endpoint
    ) -> Single<Endpoint.Response> {
        return Single.create { observer in
            self.loadData(of: endpoint) { result in
                switch result {
                case let .success(data):
                    do {
                        let decoded = try endpoint.decode(data)
                        observer(.success(decoded))
                    } catch {
                        _ = String(data: data, encoding: .utf8)
                    }

                case let .failure(error):
                    switch error {
                    case let .unknown(mgcError):
                        observer(.failure(mgcError))
                    default:
                        observer(.failure(error))
                    }
                }
            }
            return Disposables.create()
        }
        .retry { error in
            Observable.zip(error, Observable.range(start: 1, count: 3), resultSelector: { ($0, $1) })
                
            // 여기서 Single이 아니고 Observable로 작성해준 이유는 Error를 전달해주기 위함
                .flatMap { (error: HTTPError, index: Int) -> Observable<String> in
                    print("🌱", error, index)
                    switch error {
                    case .unauthorized:
                        return FirebaseAuthRepositoryImpl().requestIDToken().asObservable()
                    default:
                        return Observable.error(error)
                    }
                }
        }
    }
    
    private func loadData(
        of urlRequestable: any URLRequestable,
        completion: @escaping (Result<Data, HTTPError>) -> Void
    ) {
        do {
            let urlRequest = try urlRequestable.makeURLRequest()

            let task = session.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    completion(.failure(.specific(error)))
                }
                
                guard let response = response as? HTTPURLResponse else {
                    return completion(.failure(.noResponse))
                }
                
                switch response.statusCode {
                case 200:
                    return completion(.success(data ?? .empty))
                case 401:
                    return completion(.failure(.unauthorized))
                case 406:
                    return completion(.failure(.noUser))
                case 500:
                    return completion(.failure(.serverError))
                case 501:
                    return completion(.failure(.badRequest))
                default:
                    return completion(.failure(.unknown(MGCError(code: response.statusCode, message: "에러 발생"))))
                }
            }
            
            task.resume()
            
        } catch {
            return completion(.failure(.requestFail))
        }
    }
}
