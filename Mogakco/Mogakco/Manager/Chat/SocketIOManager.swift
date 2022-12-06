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
    
    var listener: ((Chat) -> Void)!
    
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSS'Z"
        return dateFormatter
    }
    
    private init() {
        if let socketURL = URL(string: Env.baseURL) {
            manager = SocketManager(socketURL: socketURL, config: [
                .forceWebsockets(true)
            ])
        }
        
        socket = manager.defaultSocket

        // 소켓 연결 메서드
        socket.on(clientEvent: .connect) { [weak self] data, ack in
            print("SOCKET IS CONNECTED", data, ack)
            
            // emit된 이후부터 "chat"을 통해 소켓을 들을 수 있음
            self?.socket.emit("changesocketid", "27MExocZoaX2BwYAPOMNZJp1mjY2")
        }
        
        /// 연결 해제
        socket.on(clientEvent: .disconnect) { data, ack in
            print("SOCKET IS DISCONNECTED", data, ack)
        }
        
        /// 이벤트 수신
        socket.on("chat") { [weak self] data, ack in
            print("CHAT RECEIVED", data, ack)
   
            if let data = data.first as? NSDictionary,
               let from = data["from"] as? String,
               let content = data["chat"] as? String,
               let date = data["createdAt"] as? String {
            
                let chat = Chat(
                    uid: from,
                    chat: content,
                    date: self!.dateFormatter.date(from: date)!
                )
                self?.listener(chat)
            }
        }
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
}
