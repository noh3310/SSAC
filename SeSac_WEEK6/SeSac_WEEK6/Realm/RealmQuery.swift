//
//  RealmQuery.swift
//  SeSac_WEEK6
//
//  Created by 노건호 on 2021/11/05.
//

import Foundation
import RealmSwift
import UIKit

extension UIViewController {
    
    func searchQueryFromUserDiary(text: String) -> Results<UserDiary> {
        let localRealm = try! Realm()
        
        // String -> ' ', AND, OR 둘다 가능함
        // contains[c]는 안에 값이 있는지 확인함
        let search = localRealm.objects(UserDiary.self).filter("diaryTItle == '\(text)' AND content CONTAINS[c] '\(text)'")
        print("search: ", search)
        
        return search
    }
    
    
    func getAllDiaryCountFromUserDiary() -> Int {
        let localRealm = try! Realm()
        
        let count = localRealm.objects(UserDiary.self).count
        print("count: ", count)
        
        return count
    }
}
