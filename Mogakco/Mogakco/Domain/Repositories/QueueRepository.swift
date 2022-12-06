//
//  QueueRepository.swift
//  Mogakco
//
//  Created by taekki on 2022/12/07.
//

import Foundation

// QueueRepository Interface
protocol QueueRepository {
    func fetchQueueList(lat: Double, long: Double, completion: @escaping (Result<SearchResponseDTO, Error>) -> Void)
}
