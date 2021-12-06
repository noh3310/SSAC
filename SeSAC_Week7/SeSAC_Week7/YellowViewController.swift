//
//  YellowViewController.swift
//  SeSAC_Week7
//
//  Created by 노건호 on 2021/11/10.
//

import UIKit

protocol PassDataDelegate {
    func sendTextData(text: String)
    
}

class YellowViewController: UIViewController {
    
    var textSpace: String = ""
    
    @IBOutlet weak var textView: UITextView!

    var buttonActionHandler: (() -> ())?
    
    var delegate: PassDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = textSpace
    }

    @IBAction func buttonClicked(_ sender: UIButton) {
        
        // 화면이 종료될 때 첫번째 뷰 컨트롤러로 값 전달
        buttonActionHandler?()
        
        // 자신을 호출한 뷰컨트롤러를 담아줌
        guard let presentVC = self.presentingViewController else { return }
        
        // 화면이 꺼지고난 후 팝업화면이 뜰 수 있도록 함
        self.dismiss(animated: true) {
            print("화면이 닫혔다.")
            
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "PopupViewController") as? PopupViewController else { return }
            
            presentVC.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func notificationButtonClicked(_ sender: UIButton) {
        // notificationcenter에서 post로 값 전달 가능
        NotificationCenter.default.post(name: NSNotification.Name("firstNotification"), object: nil, userInfo: ["myText": textView.text!, "value": 123])
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func protocolButtonClicked(_ sender: UIButton) {
        
        if let text = textView.text {
            delegate?.sendTextData(text: text)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}
