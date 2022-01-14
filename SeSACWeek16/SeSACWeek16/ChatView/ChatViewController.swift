//
//  ChatViewController.swift
//  SeSACWeek16
//
//  Created by 노건호 on 2022/01/13.
//

import UIKit
import Alamofire
import SnapKit

class ChatViewController: UIViewController {
    
    // 채팅 토큰
    let name = "Jerry"
    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxZTBjNWIxYmUzNDViZDllZDBjN2QyZSIsImlhdCI6MTY0MjEyMDYyNSwiZXhwIjoxNjQyMjA3MDI1fQ.FbKtzm83YY5TI-p9yfA14DlEX19pmaYYkRq6Rpcrva4"
    let url = "http://test.monocoding.com:1233/chats"
    
    var list = [Chat]()
    
    let tableView = UITableView()
    
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(MyChatView.self, forCellReuseIdentifier: MyChatView.identifier)
        tableView.register(OtherChatView.self, forCellReuseIdentifier: OtherChatView.identifier)
//        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        view.addSubview(button)
        button.setTitle("보내기", for: .normal)
        button.addTarget(self, action: #selector(barButtonClicked), for: .touchUpInside)
        button.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(20)
        }
        requestChats()
        
        NotificationCenter.default.addObserver(self, selector: #selector(getMessage(notification:)), name: NSNotification.Name("getMessage"), object: nil)
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "보내기", style: .plain, target: self, action: #selector(barButtonClicked))
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        SocketIOManager.shared.closeConnection()
    }
    
    @objc func barButtonClicked() {
        postChat()
    }
    
    @objc func getMessage(notification: NSNotification) {
        let chat = notification.userInfo!["chat"] as! String
        let name = notification.userInfo!["name"] as! String
        let createdAt = notification.userInfo!["createdAt"] as! String
        
        let value = Chat(text: chat, userID: "", name: name, username: name, id: "", createdAt: createdAt, updatedAt: "", v: 0, lottoID: "")
        
        list.append(value)
        tableView.reloadData()
        self.tableView.scrollToRow(at: IndexPath(row: self.list.count - 1, section: 0), at: .bottom, animated: false)
    }
    
    func postChat() {
        let header: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json"
        ]
        
        let array = ["1", "2", "3", "4", "5"]
        
        // POST로 전송만 하면 알아서 해줌
        AF.request(url, method: .post, parameters: ["text": "\(array.randomElement()!)"], encoder: JSONParameterEncoder.default, headers: header).responseString { data in
            print("POST CHAT SUCCEED ", data)
        }
    }
    
    // 채팅내용 가져오기
    // DB(last chat time): 나중에는 DB에 기록된 채팅의 마지막 시간을 서버에 요청. 새로운 데이터만 서버에서 받아오기!
    func requestChats() {
        let header: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json"
        ]
        AF.request(url, method: .get, headers: header).responseDecodable(of: [Chat].self) { response in
            switch response.result {
            case .success(let value):
                self.list = value
                self.tableView.reloadData()
                self.tableView.scrollToRow(at: IndexPath(row: self.list.count - 1, section: 0), at: .bottom, animated: false)
                SocketIOManager.shared.establishConnection()
            case .failure(let error):
                print("fail, ", error)
            }
        }
    }
    
}

struct Chat: Codable {
    let text, userID, name, username: String
    let id, createdAt, updatedAt: String
    let v: Int
    let lottoID: String

    enum CodingKeys: String, CodingKey {
        case text
        case userID = "userId"
        case name, username
        case id = "_id"
        case createdAt, updatedAt
        case v = "__v"
        case lottoID = "id"
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count = ", list.count)
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = list[indexPath.row]
        
        if data.name == name {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyChatView.identifier, for: indexPath) as! MyChatView
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            cell.chatLabel.text = data.text
            
//            var content = cell.defaultContentConfiguration()
//            content.text = data.text
//
//            cell.contentConfiguration = content
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: OtherChatView.identifier, for: indexPath) as! OtherChatView
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            cell.userNameLabel.text = data.name
            cell.chatLabel.text = data.text
            
//            var content = cell.defaultContentConfiguration()
//            content.text = data.text
//
//            cell.contentConfiguration = content
            
            return cell
        }
        
////        var content = cell.defaultContentConfiguration()
////        content.text = "안녕"
////        content.image = UIImage(systemName: "star.fill")
//
//        cell.contentConfiguration = content
        
//        return cell
    }
}
