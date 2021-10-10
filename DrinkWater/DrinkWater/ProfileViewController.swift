//
//  ProfileViewController.swift
//  DrinkWater
//
//  Created by 노건호 on 2021/10/11.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var userStateImage: UIImageView!
    @IBOutlet var userNickname: UITextField!
    @IBOutlet var userHeight: UITextField!
    @IBOutlet var userWeight: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 상단 버튼 설정
        setTitleBar()
        
        // 배경색 설정
        setBackgroundColor()
        
        // 이미지 설정
        setImage()
        
        // 텍스트 필드값 설정(기본값, placeholder, 배경, border, 텍스트 색상)
        setTextFields()
    }
    
    func setTitleBar() {
        // saveButton 텍스트 설정
        saveButton.title = "저장"
        saveButton.tintColor = .white
        
        // 뒤로가기 버튼 색상 변겅
        self.navigationController?.navigationBar.tintColor = .white
        
        // 네비게이션 백버튼 설정
        setNavigationBackButton()
    }
    
    // 배경색 설정
    func setBackgroundColor() {
        // 배경색 설정
        // R: 77, G: 148, B: 113
        self.view.backgroundColor = UIColor(red: 77/255, green: 148/225, blue: 113/255, alpha: 1)
    }
    
    // 이미지 설정
    func setImage() {
        // 이미지 초기화(이건 그냥 메인 컨트롤러에서 UserDefaults에 저장한 값을 출력해주면 됨
        let image = UserDefaults.standard.string(forKey: "UserDrinkImage") ?? "1-1"
        userStateImage.image = UIImage(named: image)
    }
    
    //
    func setTextFields() {
        // UserDefaults로부터 닉네임, 키, 몸무게 받아옴
        let nickname = UserDefaults.standard.string(forKey: "userNickname")
        let height = UserDefaults.standard.integer(forKey: "height")
        let weight = UserDefaults.standard.integer(forKey: "weight")
        
        // 텍스트필드에 업데이트 해줌, 단, 유저 정보가 없다면 아무것도 안보여줌
        userNickname.text = nickname
        userHeight.text = height == 0 ? "" : String(height)
        userWeight.text = weight == 0 ? "" : String(weight)
        
        // placeholder 설정
        userNickname.placeholder = "닉네임을 설정해주세요"
        userHeight.placeholder = "키(cm)을 설정해주세요"
        userWeight.placeholder = "몸무게(kg)를 설정해주세요"
        
        // background, border설정
        userNickname.backgroundColor = .clear
        userNickname.borderStyle = .none
        userHeight.backgroundColor = .clear
        userHeight.borderStyle = .none
        userWeight.backgroundColor = .clear
        userWeight.borderStyle = .none
        
        //텍스트 색상 변경
        userNickname.textColor = .white
        userHeight.textColor = .white
        userWeight.textColor = .white
        
        // 키, 몸무게 숫자만 입력 가능하도록 변경
        userHeight.keyboardType = .numberPad
        userWeight.keyboardType = .numberPad
    }
    
    @IBAction func saveButtonClicked(_ sender: UIBarButtonItem) {
        // 사용자가 입력한 입력값을 받아옴
        let nickname = userNickname.text
        let height = userHeight.text
        let weight = userWeight.text
        
        let addInfo = checkUserInfo(nickname: nickname, height: height, weight: weight)
        
        // 만약 3개를 다 입력했다면 UserDefaults에 저장
        if addInfo.count == 0 {
            saveUserInfo(nickname: nickname, height: height, weight: weight)
        }
        
        // 만약 전부 입력하지 못했다면 alert 출력
        else {
            missTextValue(addInfo: addInfo)
        }
    }
    
    func setNavigationBackButton() {
        // 네비게이션 컨트롤러에서 스와이프로 뒤로가기 못하게 설정
        // 나중에 체크 함수를 만들어서 제대로 입력이 안되어있으면 뒤로 못가게 만들기
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false

        let backButton = UIBarButtonItem(title: "물 마시기", style: .plain, target: self, action: #selector(GoToBack))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.hidesBackButton = true
    }
    
    // 입력하지 않은 값을 배열로 리턴해줌
    func checkUserInfo(nickname: String?, height: String?, weight: String?) -> [String] {
        // 만약 입력하지 않았거나, 부적절한 값이 있다면 배열에 추가해줌
        var addInfo: [String] = []
        if nickname! == "" {
            addInfo.append("닉네임")
        }
        if height == Optional("") || Int(height!) == 0 {
            addInfo.append("키")
        }
        if weight == Optional("") || Int(weight!) == 0 {
            addInfo.append("몸무게")
        }
        
        return addInfo
    }
    
    func saveUserInfo(nickname: String?, height: String?, weight: String?) {
        UserDefaults.standard.set(nickname!, forKey: "userNickname")
        UserDefaults.standard.set(Int(height!), forKey: "height")
        UserDefaults.standard.set(Int(weight!), forKey: "weight")
        
        let alert = UIAlertController(title: "저장에 성공하셨습니다.", message: "홈 화면으로 돌아갑니다.", preferredStyle: UIAlertController.Style.alert)
        
        //홈화면으로 돌아감
        let defaultAction = UIAlertAction(title: "확인", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(defaultAction)
        
        present(alert, animated: false, completion: nil)
    }
    
    // 누락된 정보 문자열에 더해줘서 Alert 발생시킴
    func missTextValue(addInfo: [String]) {
        // 누락된 정보 문자열에 더해주기
        var missValue = ""
        for index in addInfo.indices {
            missValue += addInfo[index]
            missValue += (index < addInfo.count - 1) ? ", " : " "
        }
        
        let alert = UIAlertController(title: "\(missValue)정보가 누락되었거나 잘못된 입력방법입니다.", message: "다시 입력해주세요.", preferredStyle: UIAlertController.Style.alert)
        
        let defaultAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(defaultAction)
        
        present(alert, animated: false, completion: nil)
    }
    
    // 뒤로가기 버튼 custom
    @objc
    func GoToBack(){
        // UserDefaults로부터 닉네임, 키, 몸무게 받아옴
        let nickname = UserDefaults.standard.string(forKey: "userNickname")
        let height = UserDefaults.standard.integer(forKey: "height")
        let weight = UserDefaults.standard.integer(forKey: "weight")
        
        let userNickname = userNickname.text
        let userHeight = userHeight.text
        let userWeight = userWeight.text
        
        // 유저 정보가 없는데 입력값도 제대로 안했을 때
        if (nickname == nil && userNickname == "") ||
            (height == 0 && userHeight == "") ||
            (weight == 0 && userWeight == "") {
            let addInfo = checkUserInfo(nickname: userNickname, height: userHeight, weight: userWeight)
            
            // 입력안한값 입력하라고 알려줌
            missTextValue(addInfo: addInfo)
        }
        // 유저정보는 없는데 입력한 값이 3개다 있을 때
        else if (nickname == nil && userNickname != "") &&
                (height == 0 && userHeight != "") &&
                (weight == 0 && userWeight != "") {
            // alert 출력
            let alert = UIAlertController(title: "유저 정보가 저장되지 않았습니다.", message: "유저 정보를 저장하고 싶으면\n확인 버튼을 클릭해주세요.", preferredStyle: UIAlertController.Style.alert)
            let yesAction = UIAlertAction(title: "확인", style: .default) {(action) in
                // 유저정보 저장
                self.saveUserInfo(nickname: userNickname, height: userHeight, weight: userWeight)
                self.navigationController?.popViewController(animated: true)
            }
            let noAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alert.addAction(yesAction)
            alert.addAction(noAction)
            
            present(alert, animated: false, completion: nil)
        }
        // 유저정보가 이미 저장되어 있을 때
        else {
            self.navigationController!.popViewController(animated: true)
        }
    }
    
    // 키보드 다른곳 클릭하면 내려주기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}
