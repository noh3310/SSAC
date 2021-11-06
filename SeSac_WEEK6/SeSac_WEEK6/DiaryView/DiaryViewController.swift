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
    
    @IBOutlet weak var dateButton: UIButton!
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
        
        
        let format = DateFormatter()
        format.dateFormat = "yyyy년 MM월 dd일"
        
//        let buttonDate = dateButton.currentTitle!
//        let value = format.date(from: buttonDate)!
        
//        guard let date = dateButton.currentTitle, let value = format.date(from: date) else { return }
        
        guard let date = dateButton.currentTitle, let value = DateFormatter().customFormat.date(from: date) else { return }
        
        let task = UserDiary.init(diaryTitle: titleTextField.text!, content: diaryLabel.text!, writeDate: value, regDate: Date())
        try! localRealm.write {
            localRealm.add(task)
            
            saveImageToDocumentDirectory(imageName: "\(task._id).png", image: imageView.image!)
        }
    }
    
    func saveImageToDocumentDirectory(imageName: String, image: UIImage) {
        // 1. 이미지 저장할 경로 설정: 도큐먼트 폴더, FileManager.default로 싱글톤 패턴으로 접근가능
        // Desktop/jack/ios/folder가 작성이 되고, 이것은 iOS의 Sandbox 시스템 때문에 고정적으로 사용할 수 없고, 계속 변한다.
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        // 2. 이미지 파일 이름 & 최종 경로 설정
        // Desktop/jack/ios/folder/222.png
        let imageURL = documentDirectory.appendingPathComponent(imageName)
        
        // 3. 이미지 압축
        guard let data = image.pngData() else { return }
        
        // 이건 JPEG 압축이 가능함
        guard let jpegData = image.jpegData(compressionQuality: 0.2) else { return }
        
        // 4. 이미지 저장: 동일한 경로에 이미지를 저장하게 될 경우, 덮어쓰기
        // 4-1. 이미지 경로 여부 확인
        if FileManager.default.fileExists(atPath: imageURL.path) {
            // 4-2. 기존 경로에 있는 이미지 삭제(삭제안하고 넣으면 덮어쓰기 되지 않지만 공부용으로 알아보기
            do {
                try FileManager.default.removeItem(at: imageURL)
                print("이미지 삭제 완료")
            } catch {
                print("이미지를 삭제하지 못했습니다.")
            }
        }
        // 5. 이미지를 도큐먼트에 저장
        do {
            try jpegData.write(to: imageURL)
        } catch {
            print("이미지 저장 못함")
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
    
    // PickerView로 날짜 설정
    @IBAction func dateButtonClicked(_ sender: UIButton) {
        let alert = UIAlertController(title: "날짜 선택", message: "날짜를 선택해주세요", preferredStyle: .alert)
        
        // Alert 커스터마이징
        // 1. alert 안에 들어와서 문제가 생기나?
        // 2. 스토리보드를 인식하지 못해서 그런가?
        // 3. 스토리보드 씬 + 클래스 -> 화면 전환 코드를 사용해주면 됨
//        let contentView = DatePickerViewController()
        guard let contentView = storyboard?.instantiateViewController(withIdentifier: DatePickerViewController.identifier) as? DatePickerViewController else {
            print("DatePickerViewController에 오류가 있음")
            return
        }
        contentView.view.backgroundColor = .clear
        // alert 크기 설정
        contentView.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        alert.setValue(contentView, forKey: "contentViewController")
        // 보통 높이만 고정한다.
        contentView.preferredContentSize.height = 200
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let ok = UIAlertAction(title: "확인", style: .default) {_ in
            
            let format = DateFormatter()
            format.dateFormat = "yyyy년 MM월 dd일"
            
            let value = format.string(from: contentView.datePicker.date)
            
            self.dateButton.setTitle(value, for: .normal)
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
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
