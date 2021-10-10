//
//  ExampleViewController.swift
//  AnniversaryCalculator
//
//  Created by 노건호 on 2021/10/08.
//

import UIKit

enum GameJob {
    case rouge // 도적
    case warrior // 전사
    case mystic // 도사
    case shaman // 주술사
    case fight // 격투가
}

class ExampleViewController: UIViewController {
    
    var selectJob = GameJob.rouge
    @IBOutlet var label: UILabel!
    
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = setViewBackground()
        
        setViewBackground()
        
        label.textAlignment = .center
        

        requestNotificationAuthorization()
        
        // 열거형은 Swifch와 함께 잘 사용된다.
        switch selectJob {
        case .rouge:
            print("도적")
        case .warrior:
            print("전사")
        case .mystic:
            print("도사")
        case .shaman:
            print("주술사")
        case .fight:
            print("격투가")
        }
    }
    
    //        나중에는
    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        
        // 알림이 성공했다면 success가 성공한 상황
        userNotificationCenter.requestAuthorization(options: authOptions) { success, error in
            if success {
                self.sendNotfication()
            }
        }
    }
    
    // Notification을 보내는 함수
    func sendNotfication() {
        // 어떤 정보를 보낼 지 컨텐츠 구성
        let notificationContent = UNMutableNotificationContent()

        notificationContent.title = "물 마실 시간이에요!"
        notificationContent.body = "하루 2리터 목표 달성을 위해 열심히 달려보아요"
        notificationContent.badge = 100
        notificationContent.subtitle = "서브타이틀"
    
        // 언제 보낼지 설정: 1. 간격, 2. 캘린더, 3. 위치 기반으로 설정할 수 있다.
        // 현재 구현해놓은 것은 시간간격에 따른 알람을 주는 것이다.
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 15, repeats: false)
        // 알림 요청
        let request = UNNotificationRequest(identifier: "\(Date())",
                                            content: notificationContent,
                                            trigger: trigger)

        userNotificationCenter.add(request) { error in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
    
    
    @IBAction func showAlert(_ sender: UIButton) {
        //1. UIAlertController 생성: 밑바탕 + 타이틀 + 본문
        let alert = UIAlertController(title: nil, message: nil,  preferredStyle: .actionSheet)
        //2. UIAlertAction 생성: 버튼들..
        let ok = UIAlertAction(title: "아이폰", style: .default)
        let ok2 = UIAlertAction(title: "아이폰", style: .default)
        let ipad = UIAlertAction(title: "아이패드", style: .cancel)
        let watch = UIAlertAction(title: "워치", style: .destructive)
        
        // 컬러피커
        // let colorPicker = UIColorPickerViewController()
        
        //3. 1 + 2
        alert.addAction(ok)
        alert.addAction(ok2)
        alert.addAction(ipad)
        alert.addAction(watch)
        
        //4. present
        present(alert, animated: true, completion: nil)
    }
    
    
    
    // 1. 반환값의 타입을 옵셔널 타입으로 변경: UIColor -> UIColor?
    // 2. 반환될 값을 강제 옵셔널 해제를 한다.
    // 3. 반환될 값: ?? 을 통해서 default값을 설정할 수 있다.
    @discardableResult
    func setViewBackground() -> UIColor {
        let random: [UIColor] = [.red, .green, .black, .gray]
        
        return random.randomElement() ?? .white
    }

    

}
