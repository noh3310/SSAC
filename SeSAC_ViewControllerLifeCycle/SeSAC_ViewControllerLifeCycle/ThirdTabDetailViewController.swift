//
//  ThirdTabDetailViewController.swift
//  SeSAC_ViewControllerLifeCycle
//
//  Created by jack on 2021/10/06.
//

import UIKit

class ThirdTabDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print(self, #function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(self, #function)
    }
    


}
