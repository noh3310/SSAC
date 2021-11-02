//
//  DiaryViewController.swift
//  SeSac_WEEK6
//
//  Created by 노건호 on 2021/11/02.
//

import UIKit
import RealmSwift

class DiaryViewController: UIViewController {
    
    static let identifier = "DiaryViewController"

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var diaryLabel: UITextView!
    
    // 로컬DB Realm을 선언
    let localRealm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 타이틀바 설정
        setTitleBar()
        
        // 이미지뷰 설정
        setImageView()
        
        // 타이틀 텍스트필드 설정
        setTitleTextField()
        
        // 데이트라벨 설정
        setDateLabel()
        
        print("Realm is Located at: ", localRealm.configuration.fileURL!)
    }
    
    // 타이틀바 설정
    func setTitleBar() {
//        self.title = "일기 작성"
        navigationBar.topItem?.title = "일기 작성"
        
        
        // X 버튼
        if #available(iOS 13.0, *) {
            navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(cancelButtonClicked))
        } else {
            navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonClicked))
        }
        
        // 저장버튼
        navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
    }
    
    // X 버튼 클릭시
    @objc func cancelButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // 저장버튼 클릭시
    @objc func saveButtonClicked() {
        let task = UserDiary.init(diaryTitle: titleTextField.text!, content: diaryLabel.text!, writeDate: Date(), regDate: Date())
        try! localRealm.write {
            localRealm.add(task)
        }
    }
    
    // 이미지뷰 설정(현재는 배경색만 설정)
    func setImageView() {
        imageView.backgroundColor = .gray
    }
    
    // 타이틀 텍스트필드 설정
    func setTitleTextField() {
        titleTextField.placeholder = LocalizableString.title_input.localized
        titleTextField.textAlignment = .center
    }
    
    // 데이트라벨 설정
    func setDateLabel() {
        
    }
    
    // 피커뷰 생성
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        dateTextField.inputView = pickerView
        if let number = Int(dateTextField.text!) {
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
        dateTextField.inputAccessoryView = toolBar
    }
    
    @objc func endEditing() {
        self.view.endEditing(true)
    }
}

extension DiaryViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    // 컴포넌트의 개수
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
}
