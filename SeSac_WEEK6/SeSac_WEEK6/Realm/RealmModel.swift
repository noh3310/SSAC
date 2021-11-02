//
//  RealmModel.swift
//  SeSac_WEEK6
//
//  Created by 노건호 on 2021/11/02.
//

import Foundation
import RealmSwift

// 객체형태로 저장되어있기 때문에 클래스 이름을 바꿔주면 된다.
class UserDiary: Object {
    @Persisted(primaryKey: true) var _id: ObjectId  // 기본키
    
    @Persisted var diaryTitle: String   // 제목(필수)
    @Persisted var content: String? // 내용(옵션)
    @Persisted var writeDate = Date()   // 작성일(필수)
    @Persisted var regDate = Date()   // 등록일(필수)
    
    @Persisted var favorite: Bool   // 즐겨찾기
    
    convenience init(diaryTitle: String, content: String?, writeDate: Date, regDate: Date) {
        self.init()
        
        self.diaryTitle = diaryTitle
        self.content = content
        self.writeDate = writeDate
        self.regDate = regDate
        self.favorite = false
    }
}
