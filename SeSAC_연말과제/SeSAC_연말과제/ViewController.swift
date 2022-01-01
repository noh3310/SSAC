//
//  ViewController.swift
//  SeSAC_연말과제
//
//  Created by 노건호 on 2021/12/31.
//

import UIKit
import SnapKit

class ViewController: UIViewController, LayoutProtocol {

    let emailTextField: CustomTextField = {
        let textfield = CustomTextField()
        textfield.setPlaceholder("이메일을 입력하세요")
        return textfield
    }()
    
    let nicknameTextField: CustomTextField = {
        let textfield = CustomTextField()
        textfield.setPlaceholder("닉네임을 입력하세요")
        return textfield
    }()
    
    let passwordTextField: CustomTextField = {
        let textfield = CustomTextField()
        textfield.setPlaceholder("비밀번호를 입력하세요")
        return textfield
    }()
    
    let passwordConformTextField: CustomTextField = {
        let textfield = CustomTextField()
        textfield.setPlaceholder("비밀번호를 한번더 입력하세요")
        return textfield
    }()
    
    let registerButton: CustomButton = {
        let button = CustomButton()
        button.setButtonTitle("회원가입")
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemRed
        
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
        }
        
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(10)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(10)
        }
        
        passwordConformTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(10)
        }
        
        registerButton.snp.makeConstraints {
            $0.top.equalTo(passwordConformTextField.snp.bottom).offset(10)
        }
    }
    
}

