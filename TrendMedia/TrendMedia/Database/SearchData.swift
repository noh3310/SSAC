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
    
    @Persisted var rankingDate: String
    @Persisted var releasedDate: String
    @Persisted var title: String
    @Persisted var order: Int
    
    convenience init(rankingDate: String, releasedDate: String, title: String, order: Int) {
        self.init()
        
        self.rankingDate = rankingDate
        self.releasedDate = releasedDate
        self.title = title
        self.order = order
    }
}

//// MARK: Migration
//// In application(_:didFinishLaunchingWithOptions:)
//// 마이그레이션 버전마다 어떻게 할 것인지 처리해줌
//// 현재 버전은 2(이거 한다고 시간 다보냈네....)
//let config = Realm.Configuration(
//    schemaVersion: 2, // Set the new schema version.
//    migrationBlock: { migration, oldSchemaVersion in
//        if oldSchemaVersion < 2 {
//            // Previous Migration.
//            migration.enumerateObjects(ofType: RankingMovie.className()) { oldObject, newObject in
//                let rankingDate = oldObject!["date"] as! String
//                newObject!["rankingDate"] = rankingDate
//                newObject!["releasedDate"] = ""
//            }
//        }
//    }
//)

class Genre: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var genreNumber: Int
    @Persisted var genreTitle: String
}
