//
//  Constants.swift
//  SeSAC_WEEK5_CLASS
//
//  Created by 노건호 on 2021/10/27.
//

import Foundation

struct APIKey {
    static let NAVER_ID = "T10QP9xxucDYrZfF1bCY"
    static let NAVER_SECRET = "kcYyOUiGKO"
    
    static let KAKAO = "KakaoAK 868cca741e5d7c2b2684387b0a60ab22"
}

// 엔드포인트 주소
struct EndPoint {
    static let translateURL = "https://openapi.naver.com/v1/papago/n2mt"
    
    static let visionURL = "https://dapi.kakao.com/v2/vision/face/detect"
    
    static let lottoURL = "https://www.dhlottery.co.kr/common.do"
}
