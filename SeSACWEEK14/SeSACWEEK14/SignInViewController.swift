//
//  ViewController.swift
//  SeSACWEEK14
//
//  Created by 노건호 on 2021/12/27.
//

import UIKit
import SnapKit

class SignInViewController: UIViewController {
    
    let mainView = SignInView()
    
    var viewModel = SignInViewModel()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 뷰모델을 뷰에 연결해줌
        viewModel.username.bind {
            self.mainView.usernameTextField.text = $0
        }
        
        // 뷰에서 일어나는 데이터 변환을 뷰 모델에다 전달해줌
        mainView.usernameTextField.addTarget(self, action: #selector(usernameTextFieldDidChange(_:)), for: .editingChanged)
        
        viewModel.password.bind {
            self.mainView.passwordTextField.text = $0
        }
        
        // 뷰에서 일어나는 데이터 변환을 뷰 모델에다 전달해줌
        mainView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        
        
        mainView.signInButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
    }
    
    @objc func usernameTextFieldDidChange(_ textField: UITextField) {
        // obserable의 value에다가만 저장하면 프로퍼티 옵저버로 리스너가 실행되기 떄문에 뷰컨트롤러는 뭐가뭔지 모른다.
        viewModel.username.value = textField.text ?? ""
    }
    
    @objc func passwordTextFieldDidChange(_ textField: UITextField) {
        viewModel.password.value = textField.text ?? ""
    }

    @objc func signInButtonClicked() {
        viewModel.postUserLogin {
            DispatchQueue.main.async {
                // 만약에 로그인을 성공했다면 WindowScene이 바뀌어야 한다.
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                
                windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: MainViewController())
                // 아래 메서드를 실행 안하면 화면전환이 안됨
                windowScene.windows.first?.makeKeyAndVisible()
            }
        }
    }

}

