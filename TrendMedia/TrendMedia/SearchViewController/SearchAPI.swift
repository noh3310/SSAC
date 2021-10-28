//
//  SearchAPI.swift
//  TrendMedia
//
//  Created by 노건호 on 2021/10/28.
//

import Foundation
import Alamofire
import SwiftyJSON

class SearchAPI {
    
    static let shared = SearchAPI()
    
    // 네이버 영화 네트워크 통신
    func fetchMovieData(query: String, result: @escaping (Int, JSON) -> ()) {
        
        if let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            
            let parameters = [
                "key":apiKeys.MOVIE,
                "targetDt":query
            ]
            
            AF.request(apiURL.MOVIE, method: .get, parameters: parameters).validate(statusCode: 200...500).responseJSON { response in
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
    
}
