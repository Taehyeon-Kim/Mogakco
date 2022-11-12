//
//  NetworkMonitor.swift
//  Mogakco
//
//  Created by taekki on 2022/11/12.
//

import Foundation
import Network

/// 전역적으로 사용되기 때문에 싱글톤으로 구현
final class NetworkMonitor {
    
    typealias StatusHandler = (NWPath.Status) -> Void
    
    static let shared = NetworkMonitor()
    
    private let monitor: NWPathMonitor
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    private init() { monitor = NWPathMonitor() }

    /// 모니터링 시작
    func start(statusHandler: @escaping StatusHandler) {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.status = path.status
            
            DispatchQueue.main.async {
                statusHandler(path.status)
            }
        }
        
        monitor.start(queue: queue)
    }

    /// 모니터링 종료
    /// Rx: dispose 시
    /// VC: deinit 시
    func stop() {
        monitor.cancel()
    }
}

