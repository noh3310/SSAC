//
//  SignUpViewController.swift
//  SeSACWEEK14
//
//  Created by 노건호 on 2021/12/27.
//

import UIKit

enum Status {
    case OK
    case NO
}

class SignUpViewController: UIViewController {

    let mainView = SignUpView()
    
    let viewModel = SignUpViewModel()
    
    var status: Status?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // 뷰모델을 뷰에 연결해줌
        viewModel.username.bind {
            self.mainView.idTextField.text = $0
        }
        viewModel.email.bind {
            self.mainView.emailTextField.text = $0
        }
        viewModel.password.bind {
            self.mainView.pwTextField.text = $0
        }
        viewModel.state.bind {
            self.status = $0
        }
        
        // 뷰에서 일어나는 데이터 변환을 뷰 모델에다 전달해줌
        mainView.idTextField.addTarget(self, action: #selector(usernameTextFieldDidChange(_:)), for: .editingChanged)
        // 뷰에서 일어나는 데이터 변환을 뷰 모델에다 전달해줌
        mainView.emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
        // 뷰에서 일어나는 데이터 변환을 뷰 모델에다 전달해줌
        mainView.pwTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        
        
        mainView.registerButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)

    }
    
    @objc func usernameTextFieldDidChange(_ textField: UITextField) {
        // obserable의 value에다가만 저장하면 프로퍼티 옵저버로 리스너가 실행되기 떄문에 뷰컨트롤러는 뭐가뭔지 모른다.
        viewModel.username.value = textField.text ?? ""
    }
    
    @objc func emailTextFieldDidChange(_ textField: UITextField) {
        // obserable의 value에다가만 저장하면 프로퍼티 옵저버로 리스너가 실행되기 떄문에 뷰컨트롤러는 뭐가뭔지 모른다.
        viewModel.email.value = textField.text ?? ""
    }
    
    @objc func passwordTextFieldDidChange(_ textField: UITextField) {
        // obserable의 value에다가만 저장하면 프로퍼티 옵저버로 리스너가 실행되기 떄문에 뷰컨트롤러는 뭐가뭔지 모른다.
        viewModel.password.value = textField.text ?? ""
    }
    
    @objc func signUpButtonClicked() {
        print("클릭")
        print(viewModel.username.value)
        print(viewModel.password.value)
        print(viewModel.email.value)
        viewModel.userRegister {
            
            guard let status = self.status else {
                return
            }
            
            switch status {
            case .OK:
                print("OK")
            case .NO:
                print("NO")
            }
        }
    }
}
