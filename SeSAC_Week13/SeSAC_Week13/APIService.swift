//
//  APIService.swift
//  SeSAC_Week13
//
//  Created by 노건호 on 2021/12/21.
//

import Foundation

enum APIError: String, Error {
    case unknownError = "alert_error_unknown"
    case serverError = "alert_error_server"
}

extension APIError: LocalizedError {
    var errorDescription: String? {
//        switch self {
//        case .unknownError:
//            return NSLocalizedString(self.rawValue, comment: "")
//        case .serverError:
//            return NSLocalizedString(self.rawValue, comment: "")
//        }
        // enum을 쓰더라도 String.rawValue로 처리하면 다국어나 수정하는것에도 조금더 여유로울 수 있다.
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

class APIService {

    let sourceURL = URL(string: "http://kobis.or.kr/kobisopenapi/webservice/rest/people/searchPeopleList.json?key=f5eef3421c602c6cb7ea224104795888")!
    
    func requestCast(completion: @escaping (Cast?) -> Void) {
        URLSession.shared.dataTask(with: sourceURL) { data, response, error in
            print(data)
            print(response) // 메타데이터에 대한 정보를 가지고 있다.
            print(error)
            
            if let error = error {
                print("Error")
                self.showAlert(.unknownError)
                return
            }
            
            // 타입캐스팅 해주고, 그게 유효한 값인지 검사
            guard let response = response as? HTTPURLResponse, (200...399).contains(response.statusCode) else {
                self.showAlert(.serverError)
                return
            }
            
            // 함수에서 실질적으로 사용하는 함수를 클로저로 전달해준다.
            if let data = data, let castData = try? JSONDecoder().decode(Cast.self, from: data){
                print("Succeed", castData)
                // 성공하면 escaping 메서드로 전달
                completion(castData)
                return
            }
            
            completion(nil)
            
        }.resume()
    }
    
    func showAlert(_ msg: APIError) {
        print(msg.errorDescription)
    }
}
