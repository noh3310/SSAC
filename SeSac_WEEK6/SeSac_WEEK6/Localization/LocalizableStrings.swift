//
//  LocalizableStrings.swift
//  SeSac_WEEK6
//
//  Created by 노건호 on 2021/11/01.
//

import Foundation

enum LocalizableString: String {
    case welcome_text
    case data_backup
    
    // enum 내에서 연산 프로퍼티 설정
    var localized: String {
        // "welcome_text"으로 나오게 됨 즉, case의 이름이 그대로 나옴
        return self.rawValue.localized() // Localizable.strings
    }
    
    // 테이블을 사용해서 검색할 수도 있다.
    var localizedWithTable: String {
        return self.rawValue.localized(tableName: "Setting") // Setting.strings
    }
}
