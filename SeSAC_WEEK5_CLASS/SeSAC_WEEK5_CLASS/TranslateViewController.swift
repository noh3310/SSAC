//
//  TranslateViewController.swift
//  SeSAC_WEEK5_CLASS
//
//  Created by 노건호 on 2021/10/26.
//

import UIKit
import Alamofire
import SwiftyJSON

class TranslateViewController: UIViewController {

    @IBOutlet weak var sourceTextView: UITextView!
    @IBOutlet weak var targetTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func translateButtonClicked(_ sender: UIButton) {
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        
        let header: HTTPHeaders = [
            "X-Naver-Client-Id":"T10QP9xxucDYrZfF1bCY",
            "X-Naver-Client-Secret":"kcYyOUiGKO"
        ]
        
        let parameters = [
            "source":"ko",
            "target":"en",
            "text":sourceTextView.text!
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                self.targetTextView.text = json["message"]["result"]["translatedText"].stringValue
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
