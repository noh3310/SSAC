//
//  AsyncViewController.swift
//  SeSAC_WEEK5_CLASS
//
//  Created by 노건호 on 2021/10/29.
//

import UIKit

class AsyncViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    let url = "https://images.pexels.com/photos/3791466/pexels-photo-3791466.jpeg?cs=srgb&dl=pexels-jarod-lovekamp-3791466.jpg&fm=jpg"
    
    @IBOutlet var collectionLabels: [UILabel]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for label in collectionLabels {
            label.backgroundColor = .blue
        }
        
        // 최적화 측면에서 위의 for문보다 더 적게 걸릴것이다.
        collectionLabels.forEach {
            // 아래 내용을 extension으로 Main에서 조금 더 간단하게 표현할 수 있다.
            $0.setBorderStyle()
            
//            $0.backgroundColor = .blue
//            $0.clipsToBounds = true
//            $0.layer.borderWidth = 1
//            $0.layer.borderColor = UIColor.black.cgColor
        }
        
    }
    
    @IBAction func requestButtonClicked(_ sender: UIButton) {
        
        // 비동기로 이미지를 받아옴
        DispatchQueue.global().async {
            // 옵셔널 바인딩은 3개도 함께 사용할 수 있다.
            if let url = URL(string: self.url), let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
                
            }
        }
        
        
        
    }
}


