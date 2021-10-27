//
//  TranslateViewController.swift
//  SeSAC_WEEK5_CLASS
//
//  Created by 노건호 on 2021/10/26.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftUI

class TranslateViewController: UIViewController {

    @IBOutlet weak var sourceTextView: UITextView!
    @IBOutlet weak var targetTextView: UITextView!
    
    // 옵저빙 프로퍼티(그동안 잘못알고 있었음)
    var translteText: String = "" {
        didSet {
            self.targetTextView.text = self.translteText
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func translateButtonClicked(_ sender: UIButton) {
        
        guard let text = sourceTextView.text else { return }
        // 함수를 전달인자로 넘겨서 targetTextView의 내용을 변환한다.
        TranslatedAPIManager.shared.fetchTranslateData(text: text) { status, json in
            switch status {
            case 200:
                print(json)
                self.translteText = json["message"]["result"]["translatedText"].stringValue
            case 400:
                print(json)
                self.translteText = json["errorMessage"].stringValue
            default:
                print("ERROR")
            }
        }
    }
}
