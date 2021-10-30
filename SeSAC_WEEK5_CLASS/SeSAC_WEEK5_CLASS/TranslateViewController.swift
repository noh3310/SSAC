//
//  TranslateViewController.swift
//  SeSAC_WEEK5_CLASS
//
//  Created by 노건호 on 2021/10/26.
//

// 모듈이랑 라이브러리를 구분해서 임포트한느 경우도 있다고함
import UIKit
import Network

import Alamofire
import SwiftyJSON

class TranslateViewController: UIViewController {

    @IBOutlet weak var sourceTextView: UITextView!
    @IBOutlet weak var targetTextView: UITextView!
    
    // 옵저빙 프로퍼티(그동안 잘못알고 있었음)
    var translteText: String = "" {
        didSet {
            self.targetTextView.text = self.translteText
        }
    }
    
    // 네트워크 변경 감지 클래스
    let networkMonitor = NWPathMonitor()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 네트워크가 변경될 때마다(와이파이 <-> LTE) 호출
        // 네트워크 변경 감지 클래스를 통해 사용자의 네트워크 상태가 변경될 때마다 실행
        networkMonitor.pathUpdateHandler =  { path in
            if path.status == .satisfied {
                print("Network Connected")
                
                if path.usesInterfaceType(.cellular) {
                    print("Cellular Status")
                } else if path.usesInterfaceType(.wifi) {
                    print("Wifi Status")
                } else {
                    print("Others")
                }
                
            } else {
                print("Network Disconnected")
            }
        }
        
        // 이것을 실행해야지 변경을 감지할 수 있음
        networkMonitor.start(queue: DispatchQueue.global())
    }
    
    @IBAction func translateButtonClicked(_ sender: UIButton) {
        
        guard let text = sourceTextView.text else { return }
        
        // 원래 네트워크 관련 코드들은 다 dispatchQueue에 새롭게 스레드에 할당하여야 한다.
        DispatchQueue.global().async {
            // 함수를 전달인자로 넘겨서 targetTextView의 내용을 변환한다.
            TranslatedAPIManager.shared.fetchTranslateData(text: text) { status, json in
                switch status {
                case 200:
                    print(json)
                    DispatchQueue.main.async {
                        self.translteText = json["message"]["result"]["translatedText"].stringValue
                    }
                case 400:
                    print(json)
                    DispatchQueue.main.async {
                        self.translteText = json["errorMessage"].stringValue
                    }
                default:
                    print("ERROR")
                }
            }
        }
    }
}
