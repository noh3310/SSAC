//
//  SignViewModel.swift
//  SeSACWEEK14
//
//  Created by 노건호 on 2021/12/27.
//

import Foundation

class SignInViewModel {
    // 변경된 데이터를 바로 알 수 있도록 타입을 프로토콜로 설정
    var username: Observable<String> = Observable("jack12")
    var password: Observable<String> = Observable("12341")
    
    func postUserLogin(completion: @escaping () -> Void) {
        APIService.login(identifier: username.value, password: password.value) { userData, error in
  
            // userData가 옵셔널 타입이기 때문에 옵셔널 해제를 해줘야함
            guard let userData = userData else {
                return
            }

            // 토큰값 저장
            UserDefaults.standard.set(userData.jwt, forKey: "token")
            UserDefaults.standard.set(userData.user.username, forKey: "nickname")
            UserDefaults.standard.set(userData.user.id, forKey: "id")
            UserDefaults.standard.set(userData.user.email, forKey: "email")
            
            completion()
        }
    }
    
    func getUserName() {
        username.value = UserDefaults.standard.string(forKey: "nickname") ?? ""
    }
    
    
}
