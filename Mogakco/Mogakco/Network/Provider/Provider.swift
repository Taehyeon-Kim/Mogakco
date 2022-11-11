//
//  Provider.swift
//  Mogakco
//
//  Created by taekki on 2022/11/11.
//

import Foundation

protocol Provider {
    func request<R: Decodable, E: RequestResponsable>(with endpoint: E, completion: @escaping (Result<R, Error>) -> Void) where E.Response == R
    func request(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}
