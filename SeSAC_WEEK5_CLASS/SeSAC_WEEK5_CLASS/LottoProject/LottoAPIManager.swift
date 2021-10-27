//
//  LottoAPIManager.swift
//  SeSAC_WEEK5_CLASS
//
//  Created by 노건호 on 2021/10/27.
//

import Foundation
import Alamofire
import SwiftyJSON

class LottoAPIManager {
    
    static let share = LottoAPIManager()
    
    // 로또회차번호와 escaping 함수를 파라미터로 전달
    func fetchTranslateData(number: Int, result: @escaping (Int, JSON) -> ()) {
        
        let parameter = [
            "method":"getLottoNumber",
            "drwNo":"\(number)"
        ]
        
        AF.request(EndPoint.lottoURL, method: .get, parameters: parameter).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let status = response.response?.statusCode ?? 500
                
                result(status, json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
