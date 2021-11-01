//
//  MoviePopularListAPI.swift
//  TrendMedia
//
//  Created by 노건호 on 2021/10/30.
//

import Foundation
import Alamofire
import SwiftyJSON

class MoviePopularListAPI {
    
    static let shared = MoviePopularListAPI()
    
    func getPopularMovieList(result: @escaping (Int, JSON) -> ()) {
        
        let parameters = [
            "api_key":apiKeys.TMDB_MOVIE,
            "language":"ko-KO",
            "page":"1"
        ]
        
        AF.request(apiURL.TMDB_POLULAR_MOVIE, method: .get, parameters: parameters).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let status = response.response?.statusCode ?? 500
                
                result(status, json)
                
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getStarringInformations(id: String, result: @escaping (Int, JSON) -> ()) {
        let url = apiURL.TMDB_STARRING_INFORMATION + id
        
        let parameters = [
            "api_key":apiKeys.TMDB_MOVIE,
            "append_to_response":"credits"
        ]
        
        AF.request(url, method: .get, parameters: parameters).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let status = response.response?.statusCode ?? 500
                
                result(status, json)
                print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
                print("JSON: \(json)")
            case .failure(let error):
                print("error")
            }
        }
    }
    
}
