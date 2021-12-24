//
//  ViewController.swift
//  AccessLevelsProject
//
//  Created by 노건호 on 2021/12/23.
//

import UIKit
import AccessLevel

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        testClass.openFunction()
        
        publicClass.publicFunction()
    }


}

