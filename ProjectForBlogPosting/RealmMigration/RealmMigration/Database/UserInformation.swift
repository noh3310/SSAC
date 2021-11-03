//
//  UserInformation.swift
//  RealmMigration
//
//  Created by 노건호 on 2021/11/04.
//

import Foundation
import RealmSwift

class UserInformation: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var identifier: String
    @Persisted var password: String
    @Persisted var name: String
    @Persisted var birthday: Date
    
    convenience init(identifier: String, password: String, name: String, birthday: Date) {
        self.init()
        
        self.identifier = identifier
        self.password = password
        self.name = name
        self.birthday = birthday
    }
}
