//
//  ViewController.swift
//  FirebaseAuthProject
//
//  Created by 노건호 on 2022/01/17.
//

import UIKit
import SnapKit
import FirebaseAuth

class ViewController: UIViewController {
    
    let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "전화번호를 입력하세요"
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.text = "01099009603"
        return textField
    }()
    
    let sendButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.setTitle("휴대폰 인증", for: .normal)
        return button
    }()
    
    let varifyTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "인증번호를 입력하세요"
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    
    let varifyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.setTitle("코드번호 인증", for: .normal)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(phoneNumberTextField)
        phoneNumberTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        
        view.addSubview(sendButton)
        sendButton.snp.makeConstraints {
            $0.top.equalTo(phoneNumberTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        
        view.addSubview(varifyTextField)
        varifyTextField.snp.makeConstraints {
            $0.top.equalTo(sendButton.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        
        view.addSubview(varifyButton)
        varifyButton.snp.makeConstraints {
            $0.top.equalTo(varifyTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        
        sendButton.addTarget(self, action: #selector(sendButtonClicked), for: .touchUpInside)
        varifyButton.addTarget(self, action: #selector(varifyButtonClicked), for: .touchUpInside)
    }

    @objc func sendButtonClicked() {
        PhoneAuthProvider.provider()
          .verifyPhoneNumber("+82 01099009603", uiDelegate: nil) { verificationID, error in
              if let error = error {
                print(error)
                return
              }
              // Sign in using the verificationID and the code sent to the user
              // ...
              print("메시지로 전송")
              UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
          }
        Auth.auth().languageCode = "kr";
    }
    
    @objc func varifyButtonClicked() {
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")!
        let credential = PhoneAuthProvider.provider().credential(
          withVerificationID: verificationID,
          verificationCode: varifyTextField.text!
        )
        
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                let authError = error as NSError
                print(authError.description)
                return
            }
            // User is signed in
            // ...
            print("인증 성공")
        }
    }
}

