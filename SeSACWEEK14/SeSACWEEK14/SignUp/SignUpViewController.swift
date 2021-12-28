//
//  SignUpViewController.swift
//  SeSACWEEK14
//
//  Created by 노건호 on 2021/12/27.
//

import UIKit

class SignUpViewController: UIViewController {

    let mainView = SignUpView()
    
    let viewModel = SignUpViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 뷰에서 일어나는 데이터 변환을 뷰 모델에다 전달해줌
        mainView.idTextField.addTarget(self, action: #selector(usernameTextFieldDidChange(_:)), for: .editingChanged)
        // 뷰에서 일어나는 데이터 변환을 뷰 모델에다 전달해줌
        mainView.emailTextField.addTarget(self, action: #selector(usernameTextFieldDidChange(_:)), for: .editingChanged)
        // 뷰에서 일어나는 데이터 변환을 뷰 모델에다 전달해줌
        mainView.pwTextField.addTarget(self, action: #selector(usernameTextFieldDidChange(_:)), for: .editingChanged)
        
        
        mainView.registerButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)

    }
    
    @objc func usernameTextFieldDidChange(_ textField: UITextField) {
        // obserable의 value에다가만 저장하면 프로퍼티 옵저버로 리스너가 실행되기 떄문에 뷰컨트롤러는 뭐가뭔지 모른다.
        viewModel.username.value = textField.text ?? ""
    }
    
    @objc func signUpButtonClicked() {
//        APIService.register(username: <#T##String#>, email: <#T##String#>, password: <#T##String#>, completion: <#T##(User?, APIError?) -> Void#>)
    }
}
