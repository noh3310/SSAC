//
//  MainViewController.swift
//  NewlyCoinedWord
//
//  Created by 노건호 on 2021/10/01.
//

import UIKit

class MainViewController: UIViewController {
    
    let dictionary: [String : String] = [ "만반잘부" : "만나서 반가워 잘 부탁해", "삼귀다" : "사귀기 전 사이", "스드메" : "스튜디오, 드레스, 메이크업", "꾸안꾸" : "꾸민듯 안 꾸민듯", "슬세권" : "슬리퍼 역세권", "발컨" : "발로 컨트롤", "영고" : "영원히 고통받는", "마상" : "마음의 상처"]

    @IBOutlet var searchButton: UIButton!
    @IBOutlet var searchTextView: UITextView!
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    var buttonList: [UIButton] = []

    @IBOutlet var outputLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setSearchStackView()
        
        setButtonOf(button1)
        setButtonOf(button2)
        setButtonOf(button3)
        setButtonOf(button4)
        
        setRandomButton()
    }
    
    func setSearchStackView() {
        if #available(iOS 13.0, *) {
            searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        }
        searchButton.setTitleColor(.black, for: .normal)
        searchButton.layer.backgroundColor = UIColor.black.cgColor
        searchTextView.layer.borderWidth = 3
        searchTextView.layer.borderColor = UIColor.black.cgColor
    }
    
    func getRandomTextList() -> [String] {
        var returnList: [String] = []
        var randomString = dictionary.randomElement()!.key
        
        for _ in 0..<buttonList.count {
            while returnList.contains(randomString) {
                randomString = dictionary.randomElement()!.key
            }
            returnList.append(randomString)
        }
        
        return returnList
    }
    
    func setRandomButton() {
        let randomValueString = getRandomTextList()
        for index in 0..<buttonList.count {
            buttonList[index].setTitle(randomValueString[index], for: .normal)
        }
    }
    
    func setButtonOf(_ button: UIButton) {
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitleColor(.black, for: .normal)
        buttonList.append(button)
    }
    
    @IBAction func randomButtonClicked(_ sender: UIButton) {
        searchTextView.text = sender.currentTitle
    }
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        setRandomButton()
        
        if searchTextView.text == "" {
            print("텍스트를 입력하세요!")
        } else {
            let condition: ((String, String)) -> Bool = {
                $0.0.contains(self.searchTextView.text)
            }
            
            if dictionary.contains(where: condition) {
                outputLabel.text = dictionary[searchTextView.text]
            }
//            outputLabel.text = searchTextView.text
            
        }
        
        
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
