//
//  BaseViewController.swift
//  SeSAC_Week13
//
//  Created by 노건호 on 2021/12/22.
//

import UIKit
import SnapKit
//import Alamofire
//import Realm

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setUpConstraints()
    }
    
    func configure() {
        view.backgroundColor = .white
    }
    
    func setUpConstraints() {
        
    }
    
    
}
