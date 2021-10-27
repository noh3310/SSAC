//
//  Translated.swift
//  SeSAC_WEEK5_CLASS
//
//  Created by 노건호 on 2021/10/27.
//

import Foundation
import Alamofire
import SwiftyJSON

// 싱글톤 패턴으로 구현
class TranslatedAPIManager {
    // 자기자신을 인스턴스로 담음
    static let shared = TranslatedAPIManager()
    
    typealias CompletionHandler = (Int, JSON) -> ()
    
    // 탈출 클로저를 사용해보겠다.
    // String을 매개변수로 받고, 반환값은 없는 함수를 인자로 삽입
    // @escaping
    func fetchTranslateData(text: String, result: @escaping CompletionHandler) {
        
        let header: HTTPHeaders = [
            "X-Naver-Client-Id":APIKey.NAVER_ID,
            "X-Naver-Client-Secret":APIKey.NAVER_SECRET
        ]
        
        let parameters = [
            "source":"ko",
            "target":"en",
            "text":text
        ]
        
        // 1. 상태 코드 확인: validate(statusCode: 200...500)처럼 설정해두면 200~500의 에러코드를 JSON으로 확인할 수 있다.
        // 2. 상태 코드 분기
        AF.request(EndPoint.translateURL, method: .post, parameters: parameters, headers: header).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                // 상태코드가 온다
                let code = response.response?.statusCode ?? 500
                
                // 앞쪽에는 코드를 전달하고 뒤쪽에는 json을 전달한다.
                result(code, json)
                
            case .failure(let error):   // 네트워크가 사용되지 않는 경우(서비스가 중단된경우)는 완벽한 실패이다.
                print(error)
            }
        }
        
    }
}
