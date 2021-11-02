//
//  SearchData.swift
//  TrendMedia
//
//  Created by 노건호 on 2021/11/02.
//

import Foundation
import RealmSwift

class RankingMovie: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var date: String
    @Persisted var title: String
    @Persisted var order: Int
    
    convenience init(date: String, title: String, order: Int) {
        self.init()
        
        self.date = date
        self.title = title
        self.order = order
    }
}
