//
//  MovieMapViewController.swift
//  TrendMedia
//
//  Created by 노건호 on 2021/10/20.
//

import UIKit

class MovieMapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            self.navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(filterButtonClicked(_:)))
        } else {
            // Fallback on earlier versions
        }
    }
    
    // 필터 버튼 클릭했을 때
    @objc func filterButtonClicked(_ button: UIButton) {
        
    }
}
