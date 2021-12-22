//
//  TestViewController.swift
//  BeersJson
//
//  Created by 노건호 on 2021/12/22.
//

import Foundation
import UIKit

class TestViewController: UIViewController {
    
    // MARK: UIComponent 정의
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.backgroundColor = .systemRed
        
        return scrollView
    }()
    
    let containerView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        
        return view
    }()
    
    let image: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "star")
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemMint
        
        return imageView
    }()
    
    let imageContainer = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.addSubview(imageContainer)
        scrollView.addSubview(image)
        scrollView.addSubview(containerView)
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        imageContainer.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(150)
        }
        
        image.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(imageContainer)
        }
        
        containerView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
            make.width.equalToSuperview()
            make.left.right.top.equalToSuperview()
            make.height.equalTo(1000)
        }
    }
}
