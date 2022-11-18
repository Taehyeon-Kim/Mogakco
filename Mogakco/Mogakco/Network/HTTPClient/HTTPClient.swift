//
//  HTTPClient.swift
//  Mogakco
//
//  Created by taekki on 2022/11/18.
//

import Foundation
import RxSwift

protocol HTTPClient: AnyObject {}

/// 실제 Request를 수행하는 클래스
final class URLSessionHTTPClient: HTTPClient {

    private let session: URLSession
    private let decoder = JSONDecoder()
    
    init(
        session: URLSession = .shared
    ) {
        self.session = session
    }

    func request<T: Decodable> (
        _ type: T.Type,
        with endpoint: any RequestResponsable
    ) -> Single<T> {
        return Single.create { observer in
            do {
                let urlRequest = try endpoint.makeURLRequest()
                let task = self.session.dataTask(with: urlRequest) { data, response, error in
                    let result: Result<T, NetworkError> = Self.handle(data: data, response: response, error: error)
                    
                    switch result {
                    case let .success(data):
                        observer(.success(data))
                    case let .failure(error):
                        observer(.failure(error))
                    }
                }
                task.resume()
                
            } catch {
                observer(.failure(error))
            }
            
            return Disposables.create()
        }
    }
}

extension URLSessionHTTPClient {
    
    static func handle<T: Decodable>(
        data: Data?,
        response: URLResponse?,
        error: Error?
    ) -> Result<T, NetworkError> {
        if let error = error {
            return .failure(.urlRequest(error))
        }
        
        guard let response = response as? HTTPURLResponse else {
            return .failure(.unknown)
        }

        switch response.statusCode {
        case 200:
            guard let data = data else {
                return .failure(.emptyData)
            }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                return .success(decoded)
            } catch {
                return .failure(.decoding(error))
            }
            
        case 401:
            return .failure(.server(.invalidToken))
        case 500:
            return .failure(.server(.internalServerError))
        case 501:
            return .failure(.server(.clientError))
        default:
            return .failure(.unknown)
        }
    }
}
