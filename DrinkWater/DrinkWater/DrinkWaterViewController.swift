//
//  DrinkWaterViewController.swift
//  DrinkWater
//
//  Created by 노건호 on 2021/10/11.
//

import UIKit

class DrinkWaterViewController: UIViewController {

    @IBOutlet var resetButton: UIBarButtonItem!
    @IBOutlet var userInfoButton: UIBarButtonItem!
    @IBOutlet var todayDrinkWaterLabel: UILabel!
    @IBOutlet var stateImage: UIImageView!
    @IBOutlet var drinkWaterAmount: UITextField!
    @IBOutlet var literMilliliterCheckButton: UIButton!
    @IBOutlet var recommendedDailyDrinkWater: UILabel!
    @IBOutlet var drinkButton: UIButton!
    
    // 전체 이미지 배열을 담아놓음
    let drinkStateImageList: [UIImage] = [UIImage(named: "1-1")!, UIImage(named: "1-2")!, UIImage(named: "1-3")!, UIImage(named: "1-4")!, UIImage(named: "1-5")!, UIImage(named: "1-6")!, UIImage(named: "1-7")!, UIImage(named: "1-8")!, UIImage(named: "1-9")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        UserDefaults 초기화 방법(아무런 정보가 없을때 어떻게 수행되는지 확인할 때 실행)
//        for key in UserDefaults.standard.dictionaryRepresentation().keys {
//            UserDefaults.standard.removeObject(forKey: key.description)
//        }
                
        // 상단 Title, barButtonItem 설정
        setTitleBar()
        
        // 배경색 설정
        setBackgroundColor()
        
        // 왼쪽 상단 라벨 초기값 설정
        setTodayDrinkWaterLabel()
        
        // 입력필드 초기화
        setTextField()
        
        // 리터 밀리리터 popup 버튼 초기화
        setPopupButton()
        
        // 권장 사용량 값 출력(닉네임, 권장량 UserDefaults에서 가져옴)
        setRecommendWaterAmount()
        
        // 마시기 버튼 초기화
        setDrinkButton()
       
        // 키보드 올라오고 내려오고 설정
        keyboardSetting()
        
        // 사용자 정보가 있는지 확인하고, 만약 없다면 새롭게 등록하라고 Alert
        checkUserInformation()
        
        // 델리게이트 위임
        setTextLabelDelegate()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 유저 정보가 바뀌었을 때 반영하기 위해 닉네임, 권장량 업데이트
        setRecommendWaterAmount()
        
        // 사용자의 권장사용량이 변하므로 이미지도 맞게 변경
        setImageView()
        
        // 왼쪽 위 라벨 설정
        setDrinkWaterAmount()
    }
    
    // 상단 Title, barButtonItem 설정
    func setTitleBar() {
        // 타이틀 설정
        self.navigationItem.title = "물 마시기"
        
        // reset버튼 이미지 설정
        resetButton.title = ""
        resetButton.image = UIImage(systemName: "arrow.clockwise")
        resetButton.tintColor = .white
        
        // userInfo 버튼 이미지 설정
        userInfoButton.title = ""
        userInfoButton.image = UIImage(systemName: "person.circle")
        userInfoButton.tintColor = .white
    }
    
    // 배경 설정
    func setBackgroundColor() {
        // 배경색 설정
        view.backgroundColor = UIColor(red: 65/255, green: 148/255, blue: 114/255, alpha: 1)
    }
    
    // todayDrinkWaterLabel을 설정
    func setTodayDrinkWaterLabel() {
        // 왼쪽 상단 라벨 초기값 설정
        let drinkAmount = UserDefaults.standard.integer(forKey: "drinkAmount")
        
        // 퍼센트값 가져옴
        let percentDrink = getPercentDrink(amount: drinkAmount)
        
        // 마신 양, 퍼센트 라벨에 반영
        printTodayDrinkLabel(amount: drinkAmount, percent: percentDrink)
        
        // line 제한 없앰
        todayDrinkWaterLabel.numberOfLines = 0
    }
    
    // 마신 양, 퍼센트 라벨에 반영
    func printTodayDrinkLabel(amount: Int, percent: Int) {
        if percent >= 100 {
            todayDrinkWaterLabel.text = "잘하셨어요!\n오늘 마신 양은\n\(amount)ml\n목표를 달성하셨습니다."
            checkDrinkButtonClick(percent)
        }
        else {
            todayDrinkWaterLabel.text = "잘하셨어요!\n오늘 마신 양은\n\(amount)ml\n목표의 \(percent)%"
        }
        
        // changeFontSizeOf의 changeText 를 50크기의 사이즈로 변경
        let text = todayDrinkWaterLabel.text ?? ""
        changeFontSizeOf(text, changeText: "\(amount)ml", size: 50)
    }
    
    // 입력필드 초기화
    func setTextField() {
        // 입력버튼 숫자만 입력 가능하도록 변경
        drinkWaterAmount.keyboardType = .numberPad
        
        // placeholder, 배경, border 설정
        drinkWaterAmount.placeholder = "물의 양"
        drinkWaterAmount.backgroundColor = .clear
        drinkWaterAmount.borderStyle = .none
    }
    
    // 리터 밀리리터 Popup 버튼 초기화
    func setPopupButton() {
        // 팝업버튼 타이틀, 색상 선택
        literMilliliterCheckButton.setTitle("ml(밀리리터)", for: .normal)
        literMilliliterCheckButton.tintColor = .white
        
        // 두가지 메뉴 추가
        let ml = UIAction(title: "ml(밀리리터)", handler: { _ in })
        let litter = UIAction(title: "L(리터)", handler: { _ in })
        literMilliliterCheckButton.menu = UIMenu(title: "단위를 선택하세요", image: nil, identifier: nil, options: .singleSelection, children: [ml, litter])
    }
    
    // 이미지 설정
    func setImageView() {
        // 내가 마신 양 받아오기
        let drinkWaterAmount = UserDefaults.standard.integer(forKey: "drinkAmount")
        
        // 권장량에 비해 얼마나 먹었는지 퍼센트 확인 위해 권장량 가져옴
        let recommendAmount = getRecommendAmount() * 1000.0
        // 만약에 마신양이 없다면 그냥 0번째 있는 인덱스를 넣어줌
        let percentDrink = drinkWaterAmount == 0 ? 0 : Int((Double(drinkWaterAmount) / recommendAmount) * 100.0)
        
        // 100의 범위에서 9개로 나누려면 11로 나눈 값을 SwitchCase로 변환함
        var imageIndex = percentDrink / 11
        
        // 이미지 업데이트
        if imageIndex >= drinkStateImageList.count { imageIndex = drinkStateImageList.count - 1 }
        stateImage.image = drinkStateImageList[imageIndex]
        
        // 변경된 값을 UserDefaults에 저장
        UserDefaults.standard.set("1-\(imageIndex + 1)", forKey: "UserDrinkImage")
    }
    
    // 마시기 버튼 초기화
    func setDrinkButton() {
        // 버튼값 초기화
        drinkButton.setTitle("마시기", for: .normal)
        drinkButton.backgroundColor = .white
        drinkButton.tintColor = .black
    }
    
    // 키보드 올라오고 내려오고 설정
    func keyboardSetting() {
        // 키보드 입력할 때 텍스트버튼 올려주기
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        // 키보드 입력 종료했을 때 키보드 버튼 내리기
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // 사용자 정보가 있는지 확인하고, 만약 없다면 새롭게 등록하라고 Alert
    func checkUserInformation() {
        // UserDefaults에 정보가 없을 때 Alert 발생
        let nickname = UserDefaults.standard.string(forKey: "userNickname")
        let height = UserDefaults.standard.string(forKey: "height")
        let weight = UserDefaults.standard.string(forKey: "weight")
        
        // 만약 아무것도 입력되지 않았다면 Alert를 출력하고 사용자 정보를 입력함
        if nickname == nil || height == nil || weight == nil {
            // 이 view가 처음 로드될 때는 일단 아무값도 없다는 것이기 때문에 무조건 Alert를 발생시킴
            let alert = UIAlertController(title: "사용자 정보가 없습니다.", message: "사용자 정보를 생성합니다.\n아래 확인 버튼을 클릭해주세요.", preferredStyle: .alert)
            
            //다음화면으로 넘김
            let defaultAction = UIAlertAction(title: "확인", style: .default) { (action) in
                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") else { return }
                self.navigationController?.pushViewController(vc, animated: true)
            }
            alert.addAction(defaultAction)
            
            present(alert, animated: false, completion: nil)
        }
    }
    
    @IBAction func resetButtonClicked(_ sender: UIBarButtonItem) {
        // 이미지라벨 초기화
        stateImage.image = drinkStateImageList[0]
        
        // UserDefaults의 todayDrink 라벨을 0ml, 0%로 초기화시킴
        UserDefaults.standard.set(0, forKey: "drinkAmount")
        
        // 마신 양, 퍼센트 라벨에 반영
        printTodayDrinkLabel(amount: 0, percent: 0)
        
        // 이미지를 제일 처음 이미지로 변경
        UserDefaults.standard.set("1-1", forKey: "UserDrinkImage")
        
        // 만약 목표를 달성한 후 리셋을 누른다면, 마시기 버튼 누를 수 있게 변경
        checkDrinkButtonClick(0)
    }
    
    // 델리게이트 위임
    func setTextLabelDelegate() {
        drinkWaterAmount.delegate = self
    }
    
    @IBAction func drinkButtonClicked(_ sender: UIButton) {
        // 만약 입력값이 있다면 라벨에 반영해줌
        
        let amount = drinkWaterAmount.text
        
        // 세 조건다 만족하지 못한다면 값이 없거나 문자열에 정수 입력한 것
        if amount == Optional("") || Int(amount!) == 0 || Int(amount!) == nil {
            let alert = UIAlertController(title: "마신 양을 입력하지 않았습니다.", message: "마신 양을 입력해주세요.", preferredStyle: .alert)

            // 아무일도 일어나지 않음
            let defaultAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(defaultAction)

            present(alert, animated: false, completion: nil)
            
            return
        }
        
        // 라벨값 변경
        addDrinkAmountLabel(Int(amount!)!)

        // 이미지 변경
        setImageView()
    }
    
    // 마신 양을 증가시켜주는 메서드
    func addDrinkAmountLabel(_ drinkAmount: Int) {
        // 현재 마신양 받아옴(Int)
        var amount = UserDefaults.standard.integer(forKey: "drinkAmount")
        
        // 만약 버튼이 L(리터)라면 1000 곱해줌
        var addAmount = drinkAmount
        if literMilliliterCheckButton.titleLabel!.text == "L(리터)" { addAmount *= 1000 }
        
        // 내가 마신양을 더해줌
        amount += addAmount
        
        // 오늘 마신 양을 업데이트
        UserDefaults.standard.set(amount, forKey: "drinkAmount")
        
        // 권장량에 비해 얼마나 먹었는지 퍼센트 확인 위해 권장량 가져옴
        let percentDrink = getPercentDrink(amount: amount)
        
        // 마신 양, 퍼센트 라벨에 반영
        printTodayDrinkLabel(amount: amount, percent: percentDrink)
    }
    
    // 마신 양을 달성했을 때
    // 버튼 못누르게 바꿔주고
    func checkDrinkButtonClick(_ percent: Int) {
        // 버튼 이름 바꾸고 못누르게 하기
        if percent >= 100 {
            drinkButton.setTitle("목표를 달성했습니다!", for: .normal)
            drinkButton.isEnabled = false
        }
        else {
            drinkButton.setTitle("마시기", for: .normal)
            drinkButton.isEnabled = true
        }
    }
    
    // 마신양 라벨에 설정(viewWillAppear일때 실행)
    func setDrinkWaterAmount() {
        // 현재 마신양 받아옴(Int)
        let amount = UserDefaults.standard.integer(forKey: "drinkAmount")
        
        // 권장량에 비해 얼마나 먹었는지 퍼센트 확인 위해 권장량 가져옴
        let percentDrink = getPercentDrink(amount: amount)
        
        // 마신 양, 퍼센트 라벨에 반영
        printTodayDrinkLabel(amount: amount, percent: percentDrink)
        
        // 버튼 누를지 말지 설정
        checkDrinkButtonClick(percentDrink)
    }
    
    // 퍼센트 리턴하는 메서드
    func getPercentDrink(amount: Int) -> Int {
        let recommendAmount = getRecommendAmount() * 1000.0
        
        // 만약 amount나 recommendAmount가 0이라면 0을 리턴
        if amount == 0 || recommendAmount == 0 {
            return 0
        }
        
        return Int((Double(amount) / recommendAmount) * 100.0)
    }
    
    // 권장량을 리턴해주는 메서드
    func getRecommendAmount() -> Double {
        let height = UserDefaults.standard.integer(forKey: "height")
        let weight = UserDefaults.standard.integer(forKey: "weight")
        return Double(height + weight) / Double(100)
    }

    
    // 권장 사용량 라벨에 출력
    func setRecommendWaterAmount() {
        let nickname = UserDefaults.standard.string(forKey: "userNickname") ?? ""
        
        // UserDefaults에서 값 가져오기
        let recommendWaterAmount = getRecommendAmount()
        
        // 중간 아래 텍스트 값 초기화
        recommendedDailyDrinkWater.text = "\(nickname)님의 하루 물 권장량은 \(recommendWaterAmount)L입니다."
    }
    
    // 특정 부분 폰트크기 수정
    func changeFontSizeOf(_ text:String, changeText: String, size : CGFloat) {
        // 바꾸고자 하는 텍스트가 어느 범위에 있는지 확인
        let range = (text as NSString).range(of: changeText)
        
        // 내가 적용하고싶은 폰트 사이즈
        let fontSize = UIFont.boldSystemFont(ofSize: size)
        
        // label에 있는 Text를 NSMutableAttributedString으로 만들어준다.
        let attributedStr = NSMutableAttributedString(string: text)
        
        //위에서 만든 attributedStr에 addAttribute메소드를 통해 Attribute를 적용. kCTFontAttributeName은 value로 폰트크기와 폰트를 받을 수 있음.
        attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: fontSize, range: range)
        
        //최종적으로 내 label에 속성을 적용
        todayDrinkWaterLabel.attributedText = attributedStr
        todayDrinkWaterLabel.sizeToFit()
    }
    
    /// 키보드 설정
    // 키보드 다른곳 클릭하면 내려주기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    // 키보드 입력할 때 TextField 위로 올려주기
    @objc
    func keyboardWillShow(_ sender: Notification) {
        let userInfo: NSDictionary = sender.userInfo! as NSDictionary
        let keyboardFrame: NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        
        self.view.frame.origin.y = -keyboardHeight // Move view keyboard Height upward
    }

    // 키보드 입력 끝났을 때 위치 원래대로 변경
    @objc
    func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
}

extension DrinkWaterViewController: UITextFieldDelegate {
    // 텍스트필드 입력개수 제한
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
     
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
     
        return updatedText.count <= 4
    }
}
