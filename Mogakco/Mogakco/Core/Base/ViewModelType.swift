//
//  ViewModelType.swift
//  Mogakco
//
//  Created by taekki on 2022/11/11.
//

import Foundation

protocol ViewModelType {
    associatedtype Input    // Input 관련(데이터 스트림, 이벤트 트리거)
    associatedtype Output   // Output 관련(뷰랑 바인딩될 데이터 스트림)
    
    func transform(input: Input) -> Output // Transform(Input을 가지고 Output을 요리조리 처리)
}
