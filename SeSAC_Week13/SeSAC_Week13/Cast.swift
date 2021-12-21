//
//  Cast.swift
//  SeSAC_Week13
//
//  Created by 노건호 on 2021/12/21.
//

import Foundation


// MARK: - Welcome
struct Cast: Codable {
    let peopleListResult: PeopleListResult
}

// MARK: - PeopleListResult
struct PeopleListResult: Codable {
    let totCnt: Int
    let peopleList: [PeopleList]
    let source: String
}

// MARK: - PeopleList
struct PeopleList: Codable {
    let peopleCD, peopleNm, peopleNmEn, repRoleNm, filmoNames: String

    enum CodingKeys: String, CodingKey {
        case peopleCD
        case peopleNm, peopleNmEn, repRoleNm, filmoNames
    }
}
