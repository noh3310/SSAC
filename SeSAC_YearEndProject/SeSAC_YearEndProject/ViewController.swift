//
//  ViewController.swift
//  SeSAC_연말과제
//
//  Created by 노건호 on 2021/12/31.
//

import UIKit
import SnapKit

class ViewController: UIViewController, CustomViewProtocol {

    let emailTextField: CustomTextField = {
        let textfield = CustomTextField()
        textfield.placeholder = "이메일을 입력하세요"
        return textfield
    }()
    
    let nicknameTextField: CustomTextField = {
        let textfield = CustomTextField()
        textfield.placeholder = "닉네임을 입력하세요"
        return textfield
    }()
    
    let passwordTextField: CustomTextField = {
        let textfield = CustomTextField()
        textfield.placeholder = "비밀번호를 입력하세요"
        return textfield
    }()
    
    let passwordConformTextField: CustomTextField = {
        let textfield = CustomTextField()
        textfield.placeholder = "비밀번호를 한번더 입력하세요"
        return textfield
    }()
    
    let registerButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("회원가입", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        addViews()
        makeConstraints()
    }

    func addViews() {
        view.addSubview(emailTextField)
        view.addSubview(nicknameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(passwordConformTextField)
        view.addSubview(registerButton)
    }
    
    func makeConstraints() {
        emailTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.centerX.equalToSuperview()
        }
        
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(10)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.centerX.equalToSuperview()
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(10)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.centerX.equalToSuperview()
        }
        
        passwordConformTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(10)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.centerX.equalToSuperview()
        }
        
        registerButton.snp.makeConstraints {
            $0.top.equalTo(passwordConformTextField.snp.bottom).offset(10)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.centerX.equalToSuperview()
        }
    }
    
}

