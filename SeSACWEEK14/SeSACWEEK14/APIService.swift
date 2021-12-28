//
//  APIService.swift
//  SeSACWEEK14
//
//  Created by 노건호 on 2021/12/27.
//

import Foundation
import FileProvider

enum APIError: Error {
    case invalidResponse
    case noData
    case failed
    case invalidData
}

class APIService {
    
    static func login(identifier: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
        let url = URL(string: "http://test.monocoding.com/auth/local")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // 이렇게 처리할 수도 있고, 딕셔너리로 쓸 수도 있음
        request.httpBody = "identifier=\(identifier)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        // string -> Data로도 바꿀 수 있고, Dictionary -> JSONSerialization / Codable로 사용할 수도 있음
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // 에러가 nil인 경우 일찍 리턴을 해라
            guard error == nil else {
                completion(nil, .failed)
                return
            }
            
            // 데이터가 nil이라면 일찍 리턴을 해라
            guard let data = data else {
                completion(nil, .noData)
                return
            }
            
            // response가 nil이 아닌지, 그리고 타입캐스팅이 잘 되는지 확인
            guard let response = response as? HTTPURLResponse else {
                completion(nil, .invalidResponse)
                return
            }

            // 200번으로 올바르게 왔는지
            guard response.statusCode == 200 else {
                completion(nil, .failed)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let userData = try decoder.decode(User.self, from: data)
                // 에러가 없기 때문에 nil 리턴
                completion(userData, nil)
            } catch {
                completion(nil, .invalidData)
                print(error)
            }
            
        }.resume()
        
        
//        URLRequest(
//        URLSession.shared.dataTask(with: <#T##URLRequest#>, completionHandler: <#T##(Data?, URLResponse?, Error?) -> Void#>)
    }
    
    static func register(username: String, email: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
        
        let url = URL(string: "http://test.monocoding.com/auth/local/register")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // 이렇게 처리할 수도 있고, 딕셔너리로 쓸 수도 있음
        request.httpBody = "username=\(username)&email=\(email)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        // string -> Data로도 바꿀 수 있고, Dictionary -> JSONSerialization / Codable로 사용할 수도 있음
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                
                // 에러가 nil인 경우 일찍 리턴을 해라
                guard error == nil else {
                    completion(nil, .failed)
                    return
                }
                
                // 데이터가 nil이라면 일찍 리턴을 해라
                guard let data = data else {
                    completion(nil, .noData)
                    return
                }
                
                // response가 nil이 아닌지, 그리고 타입캐스팅이 잘 되는지 확인
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .invalidResponse)
                    return
                }
                
                // 200번으로 올바르게 왔는지
                guard response.statusCode == 200 else {
                    completion(nil, .failed)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let userData = try decoder.decode(User.self, from: data)
                    // 에러가 없기 때문에 nil 리턴
                    completion(userData, nil)
                } catch {
                    completion(nil, .invalidData)
                    print(error)
                }
                
            }
            
        }.resume()
        
    }
    
    static func lotto(_ number : Int, completion: @escaping (Lotto?, APIError?) -> Void) {
        let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)")!
        
        // string -> Data로도 바꿀 수 있고, Dictionary -> JSONSerialization / Codable로 사용할 수도 있음
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                
                
                // 에러가 nil인 경우 일찍 리턴을 해라
                guard error == nil else {
                    completion(nil, .failed)
                    return
                }
                
                // 데이터가 nil이라면 일찍 리턴을 해라
                guard let data = data else {
                    completion(nil, .noData)
                    return
                }
                
                // response가 nil이 아닌지, 그리고 타입캐스팅이 잘 되는지 확인
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .invalidResponse)
                    return
                }
                
                // 200번으로 올바르게 왔는지
                guard response.statusCode == 200 else {
                    completion(nil, .failed)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let lottoData = try decoder.decode(Lotto.self, from: data)
                    // 에러가 없기 때문에 nil 리턴
                    completion(lottoData, nil)
                } catch {
                    completion(nil, .invalidData)
                    print(error)
                }
                
                
            }
            
        }.resume()
    }
    
    static func person(_ text : String, page: Int, completion: @escaping (Person?, APIError?) -> Void) {
        //    https://api.themoviedb.org/3/search/person?api_key=7ba7403949b4658f9c4fdf6008df49e2&language=en-US&query=%ED%98%84%EB%B9%88&page=1&include_adult=false&region=ko-KR
        
        let scheme = "https"
        let host = "api.themoviedb.org"
        let path = "/3/search/person"
        let language = "ko-KR"
        
        let key = "7ba7403949b4658f9c4fdf6008df49e2"
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        var component = URLComponents()
        component.scheme = scheme
        component.host = host
        component.path = path
        component.queryItems = [
            URLQueryItem(name: "api_key", value: key),
            URLQueryItem(name: "language", value: language),
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        
        URLSession.shared.dataTask(with: component.url!) { data, response, error in
            
            DispatchQueue.main.async {
                
                
                // 에러가 nil인 경우 일찍 리턴을 해라
                guard error == nil else {
                    completion(nil, .failed)
                    return
                }
                
                // 데이터가 nil이라면 일찍 리턴을 해라
                guard let data = data else {
                    completion(nil, .noData)
                    return
                }
                
                // response가 nil이 아닌지, 그리고 타입캐스팅이 잘 되는지 확인
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .invalidResponse)
                    return
                }
                
                // 200번으로 올바르게 왔는지
                guard response.statusCode == 200 else {
                    completion(nil, .failed)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let personData = try decoder.decode(Person.self, from: data)
                    // 에러가 없기 때문에 nil 리턴
                    completion(personData, nil)
                } catch {
                    completion(nil, .invalidData)
                    print(error)
                }
                
                
            }
            
        }.resume()
    }
    
}
