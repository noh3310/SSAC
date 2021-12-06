//
//  ViewController.swift
//  SeSac_FirebaseTest
//
//  Created by 노건호 on 2021/12/06.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 회원가입: 아이디(100) > 닉네임(90) > 연락처(50) > 성별(10) > 가입 완료(5)
        // 각각 화면에 진입했을 때 최종적으로 가입한 사람의 비율이 얼마만큼인지 확인해볼 수 있다.
        
//        Analytics.logEvent(AnalyticsEvent, parameters: <#T##[String : Any]?#>)
        
        // 이벤트를 수집할 수 있도록 구현
//        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
//          AnalyticsParameterItemID: "id-\(title!)",
//          AnalyticsParameterItemName: title!,
//          AnalyticsParameterContentType: "cont",
//        ])
        
        Analytics.logEvent("share_image", parameters: [
          "name": "Jack" as NSObject,
          "full_text": "테스트" as NSObject,
        ])
    }

}

