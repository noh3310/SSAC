//
//  ViewController.swift
//  RealmMigration
//
//  Created by 노건호 on 2021/11/04.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    var userList: Results<UserInformation>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. config 설정(이전 버전에서 다음 버전으로 마이그레이션될때 어떻게 변경될것인지)
        let config = Realm.Configuration(
            schemaVersion: 2, // 새로운 스키마 버전 설정
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 2 {
                    // 1-1. 마이그레이션 수행(버전 2보다 작은 경우 버전 2에 맞게 데이터베이스 수정)
                    migration.enumerateObjects(ofType: UserInformation.className()) { oldObject, newObject in
                        newObject!["birthday"] = Date()
                    }
                }
            }
        )
        
        // 2. Realm이 새로운 Object를 쓸 수 있도록 설정
        Realm.Configuration.defaultConfiguration = config
        
        // 3. Realm에게 스키마 처리방법을 알려줬기 때문에 자동으로 Migration을 수행
        let realm = try! Realm()
        
        userList = realm.objects(UserInformation.self)
    }
}

