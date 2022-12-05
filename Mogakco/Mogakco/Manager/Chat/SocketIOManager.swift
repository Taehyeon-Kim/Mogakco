//
//  SocketIOManager.swift
//  Mogakco
//
//  Created by taekki on 2022/12/05.
//

import Foundation
import SocketIO

final class SocketIOManager {
    
    static let shared = SocketIOManager()
    
    var manager: SocketManager!
    var socket: SocketIOClient!
    
    var listener: ((NSDictionary) -> Void)!
    
    private init() {
        if let socketURL = URL(string: Env.baseURL) {
            manager = SocketManager(socketURL: socketURL, config: [
                .forceWebsockets(true)
            ])
        }
        
        // 소켓 연결 메서드
        socket.on(clientEvent: .connect) { [weak self] data, ack in
            print("Socket is connected", data, ack)
            
            // emit된 이후부터 chat을 통해 소켓을 들을 수 있음
            self?.socket.emit("changesocketid", "myUID")
        }
        
        /// 연결 해제
        socket.on(clientEvent: .disconnect) { data, ack in
            print("SOCKET IS DISCONNECTED", data, ack)
        }
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
}
