//
//  ViewController.swift
//  SeSAC_03Week
//
//  Created by 노건호 on 2021/10/12.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    // Present로 나오고, Dismess로 사라지게 된다
    @IBAction func memoButtonClicked(_ sender: UIButton) {
        // 1. 스토리보드를 특정한다
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // 2. 어떤 뷰 컨트롤러로 전환할지
        // 2. 스토리보드 내 많은 뷰 컨트롤러 중, 누구를 보여줄 것인지 선택
        let vc = storyboard.instantiateViewController(withIdentifier: "MemoTableViewController") as! MemoTableViewController
        
        // 2 - 1. 네비게이션 컨트롤러 임베드
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalTransitionStyle = .partialCurl
        nav.modalPresentationStyle = .fullScreen
        
        // 3. 뷰컨트롤러를 가져왔기 때문에 어떻게 화면 전환할지 설정하면 됨
        self.present(nav, animated: true, completion: nil)
    }
    
    @IBAction func boxOfficeButtonClicked(_ sender: UIButton) {
//        // 1. 스토리보드를 특정한다
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // 2. 어떤 뷰 컨트롤러로 전환할지
        // 2. 스토리보드 내 많은 뷰 컨트롤러 중, 누구를 보여줄 것인지 선택
        let vc = storyboard.instantiateViewController(withIdentifier: "BoxOfficeTableViewController") as! BoxOfficeTableViewController
        
        /// 여기서 1, 2번을 아래처럼 합쳐서 써도 됨, 근데 특정 상황에 메인 스토리보드에서 하지 않으면 오류가 발생할 수 있음
        let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "BoxOfficeTableViewController") as! BoxOfficeTableViewController
        
        
        // Psss Data. 3
        vc.titleSpace = "제목"
        
        
        // 3. Push를 함
        // 근데 여기에 네비게이션 컨트롤러가 있는지 확인을 먼저함, 하지만 여기에서는 네비게이션 컨트롤러가 들어와있지 않기 때문에 그냥 리턴을 해줌
        // 스토리보드에서 네비게이션 컨트롤러가 임베드되어 있지 않으면 안된다 ㅎ.
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

