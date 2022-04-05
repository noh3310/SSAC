//
//  ViewController.swift
//  SocketIOTest
//
//  Created by 노건호 on 2022/04/04.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(SocketIOManager.shared.socket.status.description)
        SocketIOManager.shared.establishConnection()
    }

    @IBAction func buttonClicked(_ sender: UIButton) {
        print(SocketIOManager.shared.socket.status)
    }
    
}

