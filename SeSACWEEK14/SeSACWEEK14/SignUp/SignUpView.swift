//
//  SignUpView.swift
//  SeSACWEEK14
//
//  Created by 노건호 on 2021/12/27.
//

import UIKit

class SignUpView: UIView, ViewRepresentable {

    
    let idTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "아이디를 입력하세요"
        
        return textField
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "이메일을 입력하세요"
        
        return textField
    }()
    
    let pwTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "비밀번호를 입력하세요"
        
        return textField
    }()
    
    let registerButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("회원가입", for: .normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(idTextField)
        self.addSubview(emailTextField)
        self.addSubview(pwTextField)
        self.addSubview(registerButton)
    }
    
    func setupConstraints() {
        pwTextField.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalTo(50)
        }
        
        idTextField.snp.makeConstraints {
            $0.bottom.equalTo(pwTextField.snp.top).offset(50)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        emailTextField.snp.makeConstraints {
            $0.bottom.equalTo(idTextField.snp.top).offset(50)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        registerButton.snp.makeConstraints {
            $0.top.equalTo(pwTextField.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
    
}
