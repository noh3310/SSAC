//
//  SignViewController.swift
//  SeSAC_Week13
//
//  Created by 노건호 on 2021/12/22.
//

import Foundation
import UIKit

class SignViewController: BaseViewController {
    
//    let imageView = UIImageView()
    let mainView = SignView()
    var viewModel = SingleViewModel()
    
    // 뷰컨트롤러의 루트뷰를 로드할 때 호출되는 메서드
    // 새로운 뷰를 반환하려고 할 때 사용
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setUpConstraints()
        
        viewModel.bind { text, color in
            self.mainView.passwordTextField.text = text
            self.mainView.passwordTextField.textColor = color
        }
        
//        mainView.setupConstraints()
    }
    
    override func configure() {
        super.configure()
//        imageView.backgroundColor = .lightGray
//        imageView.contentMode = .scaleAspectFill
        title = viewModel.navigationTitle
        mainView.emailTextField.placeholder = "이메일을 작성해주세요"
        mainView.signButton.addTarget(self, action: #selector(signButtonClicked), for: .touchUpInside)
        mainView.signButton.setTitle(viewModel.buttonTItle, for: .normal)
    }
    
    override func setUpConstraints() {
        super.setUpConstraints()
//        view.addSubview(imageView)
//        imageView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//        view.addSubview(mainView)
//        mainView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
    }
    
    @objc func signButtonClicked() {
        print(#function)
        
        guard let text = mainView.emailTextField.text else { return }
        viewModel.text = text
        
    }
    
}

extension SignViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else { return }
        viewModel.textfieldPlaceHolder = text
    }
    
}
