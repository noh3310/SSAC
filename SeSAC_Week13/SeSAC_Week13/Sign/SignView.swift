//
//  SignView.swift
//  SeSAC_Week13
//
//  Created by 노건호 on 2021/12/22.
//

import UIKit

class SignView: UIView {
    
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let signButton = UIButton()
    let textField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        emailTextField.backgroundColor = .yellow
        passwordTextField.backgroundColor = .yellow
        signButton.backgroundColor = .blue
    }
    
    func setupConstraints() {
        self.addSubview(emailTextField)
        self.addSubview(passwordTextField)
        self.addSubview(signButton)
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }
        signButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }
    }
}
