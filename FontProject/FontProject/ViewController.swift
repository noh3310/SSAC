//
//  ViewController.swift
//  FontProject
//
//  Created by Jerry on 2021/11/01.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sfFontLabel: UILabel!
    @IBOutlet weak var bmFontLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sfFontLabel.text = "샌프란시스코 폰트"
        sfFontLabel.font = UIFont(name: "SFPro-Regular", size: 20)

        bmFontLabel.text = "우아한형제들 폰트"
        bmFontLabel.font = UIFont(name: "BMJUAOTF", size: 20)
    }
}

