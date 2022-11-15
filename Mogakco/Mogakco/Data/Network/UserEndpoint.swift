//
//  UserEndpoint.swift
//  Mogakco
//
//  Created by taekki on 2022/11/13.
//

import Foundation

enum UserEndpoint {
    
    static func fetchUser() -> Endpoint<UserResponseDTO> {
        
        return Endpoint(
            baseURL: Env.baseURL,
            path: Env.apiVersion + "/user",
            method: .get,
            headers: HTTPHeader.headerWithIDToken
        )
    }
    
    static func signUp(request: SignUpRequestDTO) -> Endpoint<EmptyResponse> {
        
        return Endpoint(
            baseURL: Env.baseURL,
            path: Env.apiVersion + "/user",
            method: .post,
            bodyParameters: request,
            headers: HTTPHeader.headerWithIDToken
        )
    }
}
