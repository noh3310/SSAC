//
//  ButtonViewController.swift
//  SeSACWeek16
//
//  Created by 노건호 on 2022/01/13.
//

import UIKit

class ButtonViewController: UIViewController, UIColorPickerViewControllerDelegate {
    
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 15.0, *) {
            button.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
            button.center = view.center
            button.configurationUpdateHandler = { btn in
                if btn.isHighlighted {
                    btn.tintColor = .black
                }
            }
            button.configuration = .jackStyle()
            button.addTarget(self, action: #selector(buttonClicked1), for: .touchUpInside)
            
            view.addSubview(button)
        }
        
        dateFormatStyle()
        numberFormatStyle()
        print(deferExample())
        print(deferExample2())
        deferExample3()
    }
    
    func dateFormatStyle() {
        let value = Date()
        
        print(value)
        print(value.formatted())
        print(value.formatted(date: .omitted, time: .shortened))
        print(value.formatted(date: .complete, time: .shortened))
        
        let locale = Locale(identifier: "ko-KR")
        let result1 = value.formatted(.dateTime.locale(locale).day().month(.twoDigits).year())
        print(result1)
        
        let result2 = value.formatted(.dateTime.locale(locale).day().month(.twoDigits).year())
        print(result2)
        
    }
    
    func deferExample() -> String {
        var nickname = "고래밥"
        
        defer { // 함수까지 다 하고난 다음에 호출할 수 있도록 함
            nickname = "미묘한도사"
            print("defer")
        }
        
        return nickname
    }
    
    func deferExample2() -> String? {
        var nickname: String? = "고래밥"
        
        defer { // 함수까지 다 하고난 다음에 호출할 수 있도록 함
            nickname = nil
            print("defer")
        }
        
        return nickname
    }
    
    func deferExample3() {
        
        defer { // 함수까지 다 하고난 다음에 호출할 수 있도록 함
            print("defer1")
        }
        defer { // 함수까지 다 하고난 다음에 호출할 수 있도록 함
            print("defer2")
        }
        defer { // 함수까지 다 하고난 다음에 호출할 수 있도록 함
            print("defer3")
        }
    }
    
    func numberFormatStyle(value: Int...) {
        print(50.formatted(.percent))
        
        print(1455334324.formatted())
        
        print(23235234.formatted(.currency(code: "krw")))
        
        let result = ["올라프", "미키마우스", "뽀로로"].formatted()
        print(result)
    }
    
    @objc func buttonClicked() {
        let vc = DetailViewController()
        
        if let presentationViewController = vc.presentationController as? UISheetPresentationController {
            presentationViewController.detents = [.medium(), .large()]
        }
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func buttonClicked1() {
        let vc = ChatViewController()
        
        if let presentationViewController = vc.presentationController as? UISheetPresentationController {
            presentationViewController.detents = [.medium(), .large()]
        }
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func buttonClicked2() {
        let picker = UIColorPickerViewController()
        
        if let presentationController = picker.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium(), .large()]
            presentationController.prefersGrabberVisible = true
//            presentationController.preferredContentSize = CGSize(width: 300, height: 300)
        }
        
        self.present(picker, animated: true, completion: nil)
    }
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        if let presentationController = viewController.presentationController as? UISheetPresentationController {
            presentationController.selectedDetentIdentifier = .medium
        }
    }
}

extension UIButton.Configuration {
    static func jackStyle() -> UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "SeSAC"
        configuration.subtitle = "로그인 없이 둘러보기"
        configuration.titleAlignment = .trailing
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = .systemRed
        configuration.image = UIImage(systemName: "star.fill")
        configuration.imagePadding = 8
        configuration.cornerStyle = .capsule
        configuration.showsActivityIndicator = true
        return configuration
    }
}
