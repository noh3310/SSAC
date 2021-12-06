//
//  ViewController.swift
//  SeSAC_Week7
//
//  Created by 노건호 on 2021/11/10.
//

import UIKit

class ViewController: UIViewController, PassDataDelegate {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(firstNotification(_:)), name: NSNotification.Name("firstNotification"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(firstNotification(_:)), name: .myNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .myNotification, object: nil)
    }
    
    @objc func firstNotification(_ notification: NSNotification) {
        
        // notification에서 userInfo에 myText를 string으로 변환할 수 있는가?
        if let text = notification.userInfo?["myText"] as? String {
            textView.text = text
        }
        
        print("Notification!")
    }
    
    // 프로토콜로 받은 값 반영
    func sendTextData(text: String) {
        textView.text = text
    }

    @IBAction func buttonClicked(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "YellowViewController") as? YellowViewController else {
            return
        }
        
        // 두번째 뷰 컨트롤러가 꺼질 때 값 변경하도록 함
        vc.buttonActionHandler = {
            self.textView.text = vc.textView.text
        }
        vc.textSpace = textView.text
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func notificationButtonClicked(_ sender: UIButton) {
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "YellowViewController") as? YellowViewController else {
            return
        }
        
        // 두번째 뷰 컨트롤러가 꺼질 때 값 변경하도록 함
        vc.buttonActionHandler = {
            self.textView.text = vc.textView.text
        }
        vc.textSpace = textView.text
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func protocolButtonClicked(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "YellowViewController") as? YellowViewController else {
            return
        }
       
        vc.delegate = self
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

extension Notification.Name {
    static let myNotification = NSNotification.Name("firstNotification")
}
