//
//  FrameworkViewController.swift
//  SeSAC_Week13
//
//  Created by 노건호 on 2021/12/23.
//

import UIKit
import SeSACFramework

class FrameworkViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let open = SeSACOpen()
//        open.openFunction()
//        open.name
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        var count = 0
//        
//        for i in 1...100 {
//            count += 1
//        }
        
        let sesac = SeSACOpen()
        sesac.presentWebViewController(url: "https://www.naver.com", transitionStyle: .push, vc: self)
    }
    
}
