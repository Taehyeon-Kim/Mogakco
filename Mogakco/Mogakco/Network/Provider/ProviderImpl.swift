//
//  ProviderImpl.swift
//  Mogakco
//
//  Created by taekki on 2022/11/11.
//

import Foundation

final class ProviderImpl: Provider {
    
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<R: Decodable, E: RequestResponsable>(
        with endpoint: E,
        completion: @escaping (Result<R, Error>) -> Void
    ) where E.Response == R {
        do {
            let urlRequest = try endpoint.makeURLRequest()
            
            session.dataTask(with: urlRequest) { data, response, error in
                self.handleError(with: data, response, error) { result in
                    
                    dump(result)
                    
                    switch result {
                    case .success(let data):
                        completion(self.decode(data: data))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }.resume()
            
        } catch {
            completion(.failure(NetworkError.urlRequest(error)))
        }
    }
    
    func request(
        _ url: URL,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        session.dataTask(with: url) { [weak self] data, response, error in
            self?.handleError(with: data, response, error) { result in
                completion(result)
            }
        }.resume()
    }
}

extension ProviderImpl {
    
    private func handleError(
        with data: Data?,
        _ response: URLResponse?,
        _ error: Error?,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        dump(response)
        
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let response = response as? HTTPURLResponse else {
            completion(.failure(NetworkError.unknown))
            return
        }
        
        guard (200...299).contains(response.statusCode) else {
            print("상태코드:", response.statusCode)
            completion(.failure(NetworkError.server(InternalError(rawValue: response.statusCode) ?? .unknown)))
            return
        }
        
        guard let data = data else {
            completion(.failure(NetworkError.emptyData))
            return
        }
        
        completion(.success(data))
    }
    
    private func decode<T: Decodable>(data: Data) -> Result<T, Error> {
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return .success(decoded)
        } catch {
            return .failure(NetworkError.emptyData)
        }
    }
}
