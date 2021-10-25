//
//  LEDBoardViewController.swift
//  LEDBoard
//
//  Created by 노건호 on 2021/10/01.
//

import UIKit

class LEDBoardViewController: UIViewController {
    
    @IBOutlet var randomColorButton: UIButton!
    @IBOutlet var sendButton: UIButton!
    
    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var outputLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButtonOf(randomColorButton, color: .red)
        setButtonOf(sendButton, color: .black)
    }
    
    func setButtonOf(_ button: UIButton, color: UIColor) {
        button.setTitleColor(color, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.black.cgColor // convert
    }
    
    @IBAction func keyboardReturnKeyClieked(_ sender: UITextField) {
        view.endEditing(true)
    }
    
    @IBAction func sendButtonClicked(_ sender: UIButton) {
        outputLabel.text = inputTextField.text
    }
    
    @IBAction func randomColorButtonClicked(_ sender: UIButton) {
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
                
        outputLabel.textColor = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    // 지원되는 방향을 가로로 설정
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.landscape]
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
