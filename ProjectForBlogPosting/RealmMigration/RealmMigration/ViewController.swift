//
//  ViewController.swift
//  RealmMigration
//
//  Created by 노건호 on 2021/11/04.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    // 3. Realm에게 스키마 처리방법을 알려줬기 때문에 자동으로 Migration을 수행
    let realm = try! Realm()
    
    var userList: Results<UserInformation>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userList = realm.objects(UserInformation.self)
    }
}

