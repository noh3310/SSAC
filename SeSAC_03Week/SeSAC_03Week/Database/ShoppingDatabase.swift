//
//  ShoppingDatabase.swift
//  SeSAC_03Week
//
//  Created by 노건호 on 2021/11/02.
//

import Foundation
import RealmSwift

class ShoppingItem: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var item: String
    @Persisted var favorite: Bool
    @Persisted var checkBox: Bool
    
    convenience init(item: String) {
        self.init()
        
        self.item = item
        self.favorite = false
        self.checkBox = false
    }
}

