//
//  SocketIOManager.swift
//  SocketIOTest
//
//  Created by 노건호 on 2022/04/04.
//

import Foundation
import SocketIO

class SocketIOManager:NSObject{
    static let shared = SocketIOManager()
    
    override init() {
        super.init()
        socket = self.manager.socket(forNamespace: "/")
    }
    
    var manager = SocketManager(socketURL: URL(string: "http://192.168.0.4:3000")!, config: [.log(true), .compress])
    var socket : SocketIOClient!
    
    func establishConnection(){
        socket.connect()
    }
    
    func closeConnection(){
        socket.disconnect()
    }
}
