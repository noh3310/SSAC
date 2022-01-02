//
//  SignUpViewModel.swift
//  SeSAC_YearEndProject
//
//  Created by 노건호 on 2022/01/03.
//

import Foundation

class SignUpViewModel {
    var email: Observable<String> = Observable("")
    var nickname: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")
    
    func userRegister(completion: @escaping () -> Void) {
        print(#function)
        APIService.register(username: nickname.value, email: email.value, password: password.value) { userData, error in
            
            // userData가 옵셔널 타입이기 때문에 옵셔널 해제를 해줘야함
            guard let userData = userData else {
                print(error?.rawValue ?? "옵셔널해제 실패")
                completion()
                return
            }
            
            print("로그인 성공")
            
            // 로그인하면 UserDefaults true로 전환하기
            UserDefaults.standard.set(true, forKey: "signUp")
            
            // 토큰값 저장
            UserDefaults.standard.set(userData.jwt, forKey: "token")
            UserDefaults.standard.set(userData.user.username, forKey: "nickname")
            UserDefaults.standard.set(userData.user.id, forKey: "id")
            UserDefaults.standard.set(userData.user.email, forKey: "email")
            
            completion()
        }
    }
}
