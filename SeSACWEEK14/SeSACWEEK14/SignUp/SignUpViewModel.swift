//
//  SignUpViewModel.swift
//  SeSACWEEK14
//
//  Created by 노건호 on 2021/12/27.
//

import Foundation

class SignUpViewModel {
    // 변경된 데이터를 바로 알 수 있도록 타입을 프로토콜로 설정
    var username: Observable<String> = Observable("jack12")
    var email: Observable<String> = Observable("jack@jack.com")
    var password: Observable<String> = Observable("12341")
    var state: Observable<Status> = Observable(.OK)
    
    func userRegister(completion: @escaping () -> Void) {
        print(#function)
        APIService.register(username: username.value, email: email.value, password: password.value) { userData, error in
            
            // userData가 옵셔널 타입이기 때문에 옵셔널 해제를 해줘야함
            guard let userData = userData else {
                self.state.value = .NO
                completion()
                return
            }
            
            self.state.value = .OK
            
            // 토큰값 저장
            UserDefaults.standard.set(userData.jwt, forKey: "token")
            UserDefaults.standard.set(userData.user.username, forKey: "nickname")
            UserDefaults.standard.set(userData.user.id, forKey: "id")
            UserDefaults.standard.set(userData.user.email, forKey: "email")
            
            completion()
        }
    }
}
