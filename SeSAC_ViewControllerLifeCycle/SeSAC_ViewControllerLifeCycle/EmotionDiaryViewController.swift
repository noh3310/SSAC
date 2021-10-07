//
//  EmotionDiaryViewController.swift
//  SeSAC_ViewControllerLifeCycle
//
//  Created by 노건호 on 2021/10/06.
//

import UIKit

class EmotionDiaryViewController: UIViewController {
    
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var label3: UILabel!
    @IBOutlet var label4: UILabel!
    @IBOutlet var label5: UILabel!
    @IBOutlet var label6: UILabel!
    @IBOutlet var label7: UILabel!
    @IBOutlet var label8: UILabel!
    @IBOutlet var label9: UILabel!
    var labelList: [UILabel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelList = [label1, label2, label3, label4, label5, label6, label7, label8, label9]
        
//        1. 테두리 색상, 2. 커스텀 컬러(RGB 0~255)
        label1.layer.borderColor = UIColor.red.cgColor
        
//        140, 184, 159
        label1.backgroundColor = UIColor(red: 140/255, green: 184/255, blue: 159/255, alpha: 0.8)
        label2.backgroundColor = UIColor(named: "my_color")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        let clickButton = sender.restorationIdentifier ?? ""
        
        print("\(clickButton) 번 클릭")
        print(sender.tag)
        
        let index = (Int(clickButton) ?? 0) - 1
        print(index)
        
        let text = String(describing: labelList[index].text!)
        print(text)
        
        let endOfSentence = text.firstIndex(of: " ")!
        let firstSentence = text[...endOfSentence]
        print(firstSentence)
        
        let lastIndex = text.lastIndex(of: "점")!
        let lastSentance = text[endOfSentence..<lastIndex]
        let number = String(lastSentance).replacingOccurrences(of: " ", with: "")
        print(Int(number)!)
        
//        UserDefault에 접근해서 값 변경해주기
        UserDefaults.standard.set(Int(number)! + 1, forKey: String(firstSentence))
        let score = UserDefaults.standard.integer(forKey: String(firstSentence))
        let printLabel = "\(String(firstSentence)) \(score)점"
        labelList[index].text = printLabel
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
