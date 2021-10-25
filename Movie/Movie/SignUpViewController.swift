//
//  SignUpViewController.swift
//  Movie
//
//  Created by 노건호 on 2021/09/30.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet var id: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var nickname: UITextField!
    @IBOutlet var location: UITextField!
    @IBOutlet var code: UITextField!
    
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var additionalInformationToggleButton: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("1: viewDidLoad")
        
        registerButton.layer.cornerRadius = 5
        
        id.attributedPlaceholder = NSAttributedString(string: "이메일", attributes: [.foregroundColor: UIColor.white])
        password.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [.foregroundColor: UIColor.white])
        nickname.attributedPlaceholder = NSAttributedString(string: "닉네임", attributes: [.foregroundColor: UIColor.white])
        location.attributedPlaceholder = NSAttributedString(string: "위치", attributes: [.foregroundColor: UIColor.white])
        code.attributedPlaceholder = NSAttributedString(string: "추천 코드", attributes: [.foregroundColor: UIColor.white])
        
        additionalInformationToggleButton.onTintColor = .red

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("1: viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("1: viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("1: viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("1: viewDidDisappear")
    }
    
    @IBAction func tapClicked(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func registerAccount(_ sender: UIButton) {
        print("회원가입 정보 확인")
        print("ID: \(id.text!)")
        print("PW: \(password.text!)")
        print("NICK: \(nickname.text!)")
        print("LOCATION: \(location.text!)")
        print("CODE: \(code.text!)")
    }
    
    /*
     지금 ViewController 실습을 진행하고 있습니다.
     첫번째 ViewController에서 어떤 라이프사이클 메소드를 호출하는지 print를 해뒀는데 두번째 화면을 호출하고 다시 뒤로 오게되면 ViewController를 1개를 사용하는데
     */
    
    @IBAction func toggleButtonChanged(_ sender: UISwitch) {
        if additionalInformationToggleButton.isOn {
            nickname.isHidden = false
            location.isHidden = false
            code.isHidden = false
        } else {
            nickname.isHidden = true
            location.isHidden = true
            code.isHidden = true
        }
    }
}
