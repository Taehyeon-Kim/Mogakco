//
//  URLRequestable.swift
//  Mogakco
//
//  Created by taekki on 2022/11/19.
//

import Foundation

protocol URLRequestable {
    associatedtype Response: Decodable
    
    var url: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryItems: Encodable? { get }
    var parameters: Encodable? { get }
    
    func makeURLRequest() throws -> URLRequest
    func decode(_ data: Data) throws -> Response
}

extension URLRequestable {    
    /// URL 생성
    func makeURL() throws -> URL {
        /// URL 생성
        let urlPath = url
        guard var urlComponents = URLComponents(string: urlPath) else { throw NetworkError.components }
    
        /// Query 추가
        var urlQueryItems: [URLQueryItem] = []
        if let queryItems = try queryItems?.toDictionary() {
            urlQueryItems = queryItems.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }
        urlComponents.queryItems = !urlQueryItems.isEmpty ? urlQueryItems : nil
    
        // 최종 URL 생성
        guard let url = urlComponents.url else { throw NetworkError.components }
        return url
    }
    
    /// URLRequest 생성
    func makeURLRequest() throws -> URLRequest {
        let url = try makeURL()
        var urlRequest = URLRequest(url: url)
    
        // method
        urlRequest.httpMethod = method.rawValue
    
        // body parameters
        /// application/x-www-form-urlencoded
        if let parameters,
           let dicts = try parameters.toDictionary() {
            let output = dicts.lazy
                .map { ($0.key, $0.value) }
                .map { "\($0)=\($1)"}
                .joined(separator: "&")
            let data = output.data(using: .utf8)
            urlRequest.httpBody = data
        }
    
        // header
        headers?.forEach { urlRequest.setValue($1, forHTTPHeaderField: $0) }
    
        return urlRequest
    }
}

/// Protocol Default Implementation
/// - Decoding 기능 구현
extension URLRequestable where Response: Decodable {
    
    func decode(_ data: Data) throws -> Response {
        let decoder = JSONDecoder()
        return try decoder.decode(Response.self, from: data)
    }
}

/// Protocol Default Implementation
/// - 기본 헤더 구현
extension URLRequestable {
    
    var baseURL: String {
        return Env.baseURL + Env.apiVersion
    }
    
    var headers: [String: String]? {
        return HTTPHeaderField.default
    }
    
    var queryItems: Encodable? {
        return nil
    }
    
    var parameters: Encodable? {
        return nil
    }
}
