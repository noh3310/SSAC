//
//  FoodViewController.swift
//  Delevery
//
//  Created by 노건호 on 2021/10/01.
//

import UIKit

class FoodViewController: UIViewController {
    
    
    @IBOutlet var tagButton1: UIButton!
    @IBOutlet var tagButton2: UIButton!
    @IBOutlet var tagButton3: UIButton!
    
    @IBOutlet var userSearchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonUISettingOf(tagButton1, buttonTitle: "사탕")
        buttonUISettingOf(tagButton1, buttonTitle: "초콜릿")
        buttonUISettingOf(tagButton1, buttonTitle: "츄러스")
    }
    
//    buttonOutletName: 외부 매개변수, btn: 내부 매개변수
//    매개변수를 사용할 때 "_"는 -> 와일드카드 식별자라고 부름
    func buttonUISettingOf(_ buttonOutletName: UIButton, buttonTitle: String = "사탕") {
        buttonOutletName.setTitle(buttonTitle, for: .normal)
        buttonOutletName.setTitleColor(.black, for: .normal)
        buttonOutletName.layer.cornerRadius = 10
        buttonOutletName.backgroundColor = .white
    }
    
//    TextField에서도 Action을 생성할 수 있음
//    didEndOnExit
    @IBAction func keyboardReturnKeyClieked(_ sender: UITextField) {
//        키보드 내리기
        view.endEditing(true)
    }
    
    @IBAction func foodTagButtonClicked(_ sender: UIButton) {
        userSearchTextField.text = sender.currentTitle!
//        위 코드에서 currentTitle은 왜 Optional인가?
//        userSearchTextField.text = "\(Int.random(in: 1...100))"
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
