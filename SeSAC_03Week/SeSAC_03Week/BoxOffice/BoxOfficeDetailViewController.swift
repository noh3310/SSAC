//
//  BoxOfficeDetailViewController.swift
//  SeSAC_03Week
//
//  Created by 노건호 on 2021/10/15.
//

import UIKit

class BoxOfficeDetailViewController: UIViewController, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let pickerList = ["감자", "고구마", "파인애플", "자두", "복숭아"]
    
    // 1. 데이터 받을공간을 만들어줌
    var movieTitle: String?
    var releaseDate: String?
    var runtime: Int?
    var overview: String?
    var rate: Double?
    
    var movie: Movie?

    @IBOutlet weak var titleTextField: UITextView!
    @IBOutlet weak var overviewTextField: UITextField!
    
    @IBOutlet weak var textView3: UITextView!
    @IBOutlet weak var textView2: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.text = movie?.title
        overviewTextField.text = movie?.overview
        
        print(movie?.runtime, movie?.rate, movie?.releaseDate)
        
        // 여러줄 있는 텍스트뷰에서 placeholder는 프로토콜 사용해서 구현해야함
        // UITextViewDelegate를 부름
        // overviewTextview.delegate를 연결해줌
        titleTextField.delegate = self
        
        // 텍스트뷰에 플레이스홀더 달고싶으면: 글자, 글자 색상,
//        titleTextField.text = "이곳에 줄거리를 남겨보세요"
        titleTextField.textColor = .lightGray
        
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
//        datePicker.preferredDatePickerStyle = .wheels
        
        // InputView를 사용할 수 있다는 것이다.
        // 데이트피커를 호출하겠다.
        overviewTextField.inputView = pickerView
        
        
    }
    
    // 커서가 깜빡이기 시작할 때
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
        
    }
    
    // 커서가 끝날 때
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "이곳에 줄거리를 남겨보세요"
            textView.textColor = .lightGray
        }
    }
    
    // UIPicker 컴포넌트의 개수
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // UIPicker Row의 개수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    // pick한거 출력
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(row)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // 각각 글자가 뭐가 들어가는지
        return "\(pickerList[row])"
    }

}
