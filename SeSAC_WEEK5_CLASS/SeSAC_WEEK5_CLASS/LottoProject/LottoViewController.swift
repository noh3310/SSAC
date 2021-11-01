//
//  LottoViewController.swift
//  SeSAC_WEEK5_CLASS
//
//  Created by 노건호 on 2021/10/25.
//

import UIKit
import AVFoundation
import SwiftyJSON
import SkeletonView

class LottoViewController: UIViewController {
    
    static let identifier = "LottoViewController"
    
    @IBOutlet weak var numberTextField: UITextField!
    
    @IBOutlet weak var winningNumberLabel: UILabel!
    @IBOutlet weak var winningNumberDateLabel: UILabel!
    
    @IBOutlet weak var numberInformationLabel: UILabel!

    @IBOutlet weak var lottoLabel1: UILabel!
    @IBOutlet weak var lottoColor1: UIImageView!
    
    @IBOutlet weak var lottoLabel2: UILabel!
    @IBOutlet weak var lottoColor2: UIImageView!
    
    @IBOutlet weak var lottoLabel3: UILabel!
    @IBOutlet weak var lottoColor3: UIImageView!
    
    @IBOutlet weak var lottoLabel4: UILabel!
    @IBOutlet weak var lottoColor4: UIImageView!
    
    @IBOutlet weak var lottoLabel5: UILabel!
    @IBOutlet weak var lottoColor5: UIImageView!
    
    @IBOutlet weak var lottoLabel6: UILabel!
    @IBOutlet weak var lottoColor6: UIImageView!
    
    @IBOutlet weak var lottoLabelBonus: UILabel!
    @IBOutlet weak var lottoColorBonus: UIImageView!
    
    @IBOutlet weak var plusImageView: UIImageView!
    
    @IBOutlet weak var bonusLabel: UILabel!
    // 알게된 결과값이 있다면 프로퍼티 옵저버를 통해 메서드를 수행해서 라벨에 출력
    var lottoNumber: [Int] = [] {
        didSet {
            reflectLottoNumbers()
        }
    }
    
    var date: String = "" {
        didSet {
            setDate()
        }
    }
    
    var numberInformation: String = "" {
        didSet {
            setInformation()
        }
    }
    
    var lottoNumberStructList: [LottoNumberStruct] = []
    
    var maxLottoNumber = 987
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 로또번호 배열에 값 넣어줌
        setLottoNumberStructList()
        
        // 피커뷰 델리게이트 위임
//        numberPickerView.delegate = self
//        numberPickerView.dataSource = self
        // 처음에 피커뷰 어디를 가리킬지 설정
//        numberPickerView.selectRow(986, inComponent: 0, animated: false)
        
        // 더하기 이미지뷰 설정
        setPlusImageView()
        
        // 당첨번호 안내 출력
        winningNumberLabel.text = "당첨번호 안내"
        
        // 보너스 라벨 설정
        setBonusLabel()
        
        // 텍스트필드 설정
        self.numberTextField.text = "\(986)"
        
        // 맨처음에 986으로 찾아줌
        LottoAPIManager.share.fetchTranslateData(number: 986) { status, json in
            
            // API 명세서를 찾지못해서 어떻게 처리해야할지 모르겠음..
//            switch status {
//            case 200: break
//            case 400: break
//            default: break
//
//            }
            
            // 라벨 설정
            self.numberInformation = "\(986)회 당첨결과"
            
            // 로또날짜 변경
            self.date = json["drwNoDate"].stringValue
            
            // 로또번호 변경
            var numbers: [Int] = []
            
            for index in 1...6 {
                let number = json["drwtNo\(index)"].intValue
                numbers.append(number)
            }
            
            let bonusNumber = json["bnusNo"].intValue
            numbers.append(bonusNumber)
            
            // 정리한 값을 배열에 담아주면 프로퍼티 옵저빙에 의해서 실행된다.
            self.lottoNumber = numbers
        }
        
        createPickerView()
        dismissPickerView()
    }
    
    // 피커뷰 생성
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        numberTextField.inputView = pickerView
        if let number = Int(numberTextField.text!) {
            // 피커뷰 시작점 정해줌
            pickerView.selectRow(number, inComponent: 0, animated: false)
        }
    }
    
    // 피커뷰 사라지게함
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(self.endEditing))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        numberTextField.inputAccessoryView = toolBar
    }
    
    @objc func endEditing() {
        self.view.endEditing(true)
    }
    
    // 로또번호 배열에 값 추가
    func setLottoNumberStructList() {
        lottoNumberStructList = [
            LottoNumberStruct(number: lottoLabel1, backgroundImage: lottoColor1),
            LottoNumberStruct(number: lottoLabel2, backgroundImage: lottoColor2),
            LottoNumberStruct(number: lottoLabel3, backgroundImage: lottoColor3),
            LottoNumberStruct(number: lottoLabel4, backgroundImage: lottoColor4),
            LottoNumberStruct(number: lottoLabel5, backgroundImage: lottoColor5),
            LottoNumberStruct(number: lottoLabel6, backgroundImage: lottoColor6),
            LottoNumberStruct(number: lottoLabelBonus, backgroundImage: lottoColorBonus)
        ]
    }
    
    // 로또번호 라벨에 반영하기
    func reflectLottoNumbers() {
        for index in lottoNumberStructList.indices {
            let number = lottoNumber[index]
            let numberText = lottoNumberStructList[index].number
            numberText.text = String(number)
            numberText.textColor = .white
            
            let backgroundImage = lottoNumberStructList[index].backgroundImage
            backgroundImage.backgroundColor = getLottoNumberColor(number)
            backgroundImage.layer.cornerRadius = backgroundImage.frame.height / 2
            backgroundImage.layer.borderWidth = 1
            backgroundImage.layer.borderColor = UIColor.clear.cgColor
            backgroundImage.clipsToBounds = true
        }
    }
    
    // 로또번호에 따른 색 리턴
    func getLottoNumberColor(_ number: Int) -> UIColor {
        // 1~10: 노란색, 11~20: 하늘색, 21~30: 빨간색, 31~40: 회색, 40~45: 연두색
        switch number {
        case 1...10:
            return UIColor(red: 243/255, green: 198/255, blue: 67/255, alpha: 1)
        case 11...20:
            return UIColor(red: 129/255, green: 198/255, blue: 238/255, alpha: 1)
        case 21...30:
            return UIColor(red: 238/255, green: 122/255, blue: 118/255, alpha: 1)
        case 31...40:
            return UIColor(red: 169/255, green: 169/255, blue: 169/255, alpha: 1)
        case 41...45:
            return UIColor(red: 184/255, green: 215/255, blue: 91/255, alpha: 1)
        default:
            return UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        }
    }
    
    // 날짜 설정
    func setDate() {
        winningNumberDateLabel.text = date
        winningNumberDateLabel.textColor = .gray
    }
    
    // 더하기 이미지뷰 설정
    func setPlusImageView() {
        // 더하기 이미지 추가해줌
        plusImageView.image = UIImage(systemName: "plus")
        plusImageView.tintColor = .black
        plusImageView.contentMode = .center
    }
    
    // 보너스 라벨 설정
    func setBonusLabel() {
        bonusLabel.text = "보너스"
        bonusLabel.textColor = .gray
    }
    
    // ~회 당첨입니다 설정
    func setInformation() {
        numberInformationLabel.text = numberInformation
    }
}

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // 컴포넌트의 개수(스크롤할 수 있는 컴포넌트의 개수)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // pickerView의 각 Row에 출력되는 정보 설정
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)"
    }
    
    // Row의 최대개수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return maxLottoNumber
    }
    
    // pickerview에서 선택했을 때 메서드
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let userDefaults = UserDefaults.standard
        // userdefualts에서 정보 있는지 찾아보고, 만약 있다면 서버검색을 수행하지 않음
        let lottoNumber = userDefaults.integer(forKey: "\(row)")
        // 유저디폴트에 값이 있다면
        if lottoNumber != 0 {
            print("유저디폴트값 받아옴")
            let numberDay = userDefaults.string(forKey: "\(row)day")
            let lottoNumbers = userDefaults.stringArray(forKey:  "\(row)numbers")!
            
            // 문자열 함수 정수 함수로 변경(고차함수 사용)
            let intLottoNumbers = lottoNumbers.map { Int($0)! }
            
            // 메인(UI)스레드에서 텍스트값 수정
            DispatchQueue.main.async {
                self.setLottoInformation(row: row, lottoDate: numberDay!, lottoNumbers: intLottoNumbers)
            }
            
        }
        // 로또번호 없는 경우 API통신으로 받아오기
        else {
            // 정보 없어서 API로 통신
            print("정보 없어서 API로 통신")
            LottoAPIManager.share.fetchTranslateData(number: row) { status, json in
                
                // API 명세서를 찾지못해서 어떻게 처리해야할지 모르겠음..
    //            switch status {
    //            case 200: break
    //            case 400: break
    //            default: break
    //
    //            }
                
                // 로또날짜 변경
                let lottoDate = json["drwNoDate"].stringValue
                
                // 로또번호 변경
                var numbers: [Int] = []
                
                for index in 1...6 {
                    let number = json["drwtNo\(index)"].intValue
                    numbers.append(number)
                }
                
                let bonusNumber = json["bnusNo"].intValue
                numbers.append(bonusNumber)
                
                DispatchQueue.main.async {
                    self.setLottoInformation(row: row, lottoDate: lottoDate, lottoNumbers: numbers)
                }
                
                // userDefualts에 값 저장하기
                let userDefaults = UserDefaults.standard
                userDefaults.set(row, forKey: "\(row)")
                
                // 문자열 배열로 변경
                let stringNumbers = numbers.map { String($0) }
                userDefaults.set(stringNumbers, forKey: "\(row)numbers")
                
                userDefaults.set(lottoDate, forKey: "\(row)day")
            }
        }
    }
    
    // 로또번호 알아냈을 때 UI에 적용하는 부분(로또번호는 옵저빙 프로퍼티를 실행해 변경)
    func setLottoInformation(row: Int, lottoDate: String, lottoNumbers: [Int]) {
        // 텍스트필드 설정
        self.numberTextField.text = "\(row)"
        
        // 라벨 설정
        self.numberInformation = "\(row)회 당첨결과"
        
        // 로또날짜 변경
        self.date = lottoDate
        
        // 정리한 값을 배열에 담아주면 프로퍼티 옵저빙에 의해서 실행된다.
        self.lottoNumber = lottoNumbers
    }
    
}
