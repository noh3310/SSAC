//
//  SecondTabDetailViewController.swift
//  SeSAC_ViewControllerLifeCycle
//
//  Created by jack on 2021/10/06.
//

import UIKit
import TextFieldEffects

class SecondTabDetailViewController: UIViewController {
    
    
    @IBOutlet var mottoTextField: HoshiTextField!
    
    // 출첵 1 - 몇 번 출첵했는지 보여줄 레이블
    @IBOutlet var numberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 출첵
        let number = UserDefaults.standard.integer(forKey: "number")
        numberLabel.text = "\(number)"
        
//        3. UserDefault에 저장되어 있는 값 가져오기
        let userMotto = UserDefaults.standard.string(forKey: "userMotto")
        print(userMotto ?? "")
        
//        4. 값을 표현하고자 하는 뷰 객체(텍스트필드)에 보여주기
        mottoTextField.text = userMotto

        print(self, #function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(self, #function)
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        
//        1. 데이터 가져오기
        let userText = mottoTextField.text ?? "열심히 살자"
        
//        2. 데이터가 확인되면, UserDefaults에 key를 만들고, key에 데이터를 저장한다.
        UserDefaults.standard.set(userText, forKey: "userMotto")
        
    }
    
    // 출첵2 - 출석체크 버튼 누를 때의 기능
    // 10번출첵 -> 3번 버튼 누르면 -> 13번 저장
    @IBAction func checkButtonClicked(_ sender: UIButton) {
        
        //text. 랜덤 숫자 저장
        // 출첵 3 - 기존 출첵된 숫자 가져오기(10번)
        let number = UserDefaults.standard.integer(forKey: "number")
        
        // 출첵 4 - 기존 출첵된 숫자에서 1은 더한 값을 새롭게 number에 저장
        UserDefaults.standard.set(number + 1, forKey: "number")
        
        // 출첵 5 - 레이블에 보여지고 있는 값 업데이트
        let updateNumber = UserDefaults.standard.integer(forKey: "number")
        numberLabel.text = "\(updateNumber)"
    }
}
