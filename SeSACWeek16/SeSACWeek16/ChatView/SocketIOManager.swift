//
//  SocketManager.swift
//  SeSACWeek16
//
//  Created by 노건호 on 2022/01/14.
//

import Foundation
import SocketIO

class SocketIOManager: NSObject {
    
    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxZTBjNWIxYmUzNDViZDllZDBjN2QyZSIsImlhdCI6MTY0MjEyMDYyNSwiZXhwIjoxNjQyMjA3MDI1fQ.FbKtzm83YY5TI-p9yfA14DlEX19pmaYYkRq6Rpcrva4"
    
    static let shared = SocketIOManager()
    
    // 서버와 메시지를 주고받기 위한 클래스
    // 소켓을 연결하고 해제하는데 도와주는 클래스
    var manager: SocketManager!
    
    // 클라이언트 소켓
    // 사용하는것은 이것을 사용한다고 보면 된다.
    var socket: SocketIOClient!
    
    // 지금은 타입 형태로만 선언이 되어있다 데이터나 타입은 어떻게 설정이 되어있을지, Socket.io에 대한 매니저에 대한 애용이 들어있어야한다.
    override init() {
        super.init()
        
        let url = URL(string: "http://test.monocoding.com:1233")!
        manager = SocketManager(socketURL: url, config: [
            .log(true),
            .compress,
            .extraHeaders(["auth" : token])
        ])
        
        socket = manager.defaultSocket // "/"로 된 룸
        
        // 소켓 연결 요청
        socket.on(clientEvent: .connect) { data, ack in
            print("Socket is connected!", data, ack)
        }
        
        // 소켓 연결 해제 메서드
        socket.on(clientEvent: .disconnect) { data, ack in
            print("Socket is disConnected!", data, ack)
        }
        
        // 소켓 채팅 듣는 메서드, sesac 이벤트로 날아온 데이터를 수신
        // 데이터 수신 -> 디코딩 -> 모델에 추가 -> 갱신
        socket.on("sesac") { dataArray, ack in
            print("SESAC RECEIVED", dataArray, ack)
            let data = dataArray[0] as! NSDictionary
            let chat = data["text"] as! String
            let name = data["name"] as! String
            let createdAt = data["createdAt"] as! String
            
            print("CHECK", chat, name, createdAt)
            
            NotificationCenter.default.post(name: NSNotification.Name("getMessage"), object: self, userInfo: ["chat": chat, "name": name, "createdAt": createdAt])
        }
        
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
}
