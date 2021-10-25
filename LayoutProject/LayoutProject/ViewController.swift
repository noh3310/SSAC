//
//  ViewController.swift
//  LayoutProject
//
//  Created by 노건호 on 2021/10/22.
//

import UIKit

/*
 버튼을 중심에 놓고싶으면 Device의 수직 중앙, 수평 중앙에 둬야 한다.
 버튼이나 라벨 등 컨텐츠 크기에 영향을 받음
 
 
 // 기기 크기를 통해 어떤 기기인지 알 수 있는 방법
 1. width, height: UIScreen.main.bounds.width
 2. device property
 3. device library
 */

class ViewController: UIViewController {
    
    // 뷰객체 하나를 레이아웃을 잡고, 그것을 기준으로 레이아웃을 잡는 편이다.
    
    // 녹색 버튼에서는 width를 multiplyer로 설정을 했다.
    
    @IBOutlet weak var containerViewHeight: NSLayoutConstraint!
    
    var heightStatus = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 예전에 개발을 잘 몰랐을 때는 직접 if문으로 크기로 어떤 기기인지 확인했었다고 함.
        if UIScreen.main.bounds.width < 375 {
            
        }
        
        
    }

    // 버튼 클릭했을 때 컨테이너뷰의 크기를 늘리기
    @IBAction func blackButtonClicked(_ sender: UIButton) {
        heightStatus.toggle()
        
        
        containerViewHeight.constant = heightStatus ? UIScreen.main.bounds.height * 0.2 : 50
        
        UIView.animate(withDuration: 0.3) {
            // 레이아웃 조정이 필요하다면
            self.view.layoutIfNeeded()
        }
    }
    

}

