//
//  RandomViewController.swift
//  Delevery
//
//  Created by 노건호 on 2021/09/29.
//

import UIKit

class RandomViewController: UIViewController {
    
//    인터페이스 빌더 아울렛, 아울렛 변수라고 부르기도 함
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var randomLabel: UIButton!
    
//    뷰 컨트롤러의 생명주기로 검색해보면 도움이 될 것이다.
//    화면이 사용자에게 보이기 직전에 실행되는 기능: 모서리 둥글게, 그림자 속성을 준다던지, 스토리보드에서 구현하기 까다로운 UI를 미리 구현할 때 주로 사용
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.text = "안녕하세요\n반갑습니다"
        resultLabel.textAlignment = .center
        resultLabel.backgroundColor = .systemRed
        resultLabel.numberOfLines = 2
        resultLabel.font = .boldSystemFont(ofSize: 20)
        resultLabel.textColor = .blue
        resultLabel.layer.cornerRadius = 20
//        resultLabel.clipsToBounds = true
//        위 코드는 inspactor에서 설정해둘수도 있음
        
        randomLabel.backgroundColor = .magenta
        randomLabel.setTitle("행운의 숫자를 뽑아주세요", for: .normal)
        randomLabel.setTitle("뽑아 뽑아", for: .highlighted)
        randomLabel.layer.cornerRadius = 10
        randomLabel.setTitleColor(.white, for: .normal)
    }
    
    @IBAction func checkButtonClicked(_ sender: UIButton) {
//        resultLabel.text = resultLabel.text! + "1"
//        print("hello")
        let number = Int.random(in: 1...100)
        resultLabel.text = "행운의 숫자는 \(number)입니다."
    }
    
    
    
}
