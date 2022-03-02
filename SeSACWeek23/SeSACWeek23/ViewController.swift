//
//  ViewController.swift
//  SeSACWeek23
//
//  Created by 노건호 on 2022/02/28.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstTextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        firstTextField.accessibilityIdentifier = "firstTextField"
    }

    func calculateTextFieldTextCount() -> Int {
        return firstTextField.text?.count ?? 0
    }
    
    @IBAction func firstButtonClicked(_ sender: UIButton) {
        resultLabel.text = firstTextField.text
    }
    
}

