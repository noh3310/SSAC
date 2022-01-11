//
//  ViewController.swift
//  SeSACWeek16
//
//  Created by 노건호 on 2022/01/10.
//

import UIKit

// AnyObject는 타입이다.
// AnyObject는 클래스만을 담을 수 있었기 때문에 MyProtocol은 클래스를 담을 수 있다.
//
protocol myProtocol: AnyObject {
    
}



enum GameJob {
    case warrior
    case rogue
}

class Game {
    var level = 5
    var name = "도사"
    var job: GameJob = .rogue
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        anyvsAnyObject()
//        copyOnWrite()
        aboutSubScript()
        aboutForEach()
    }

    // 런타임 시점에 타입이 결정. 컴파일 시점에 알 수 없음
    // 컴파일 시점에서 알 수 없음
    // Any: Class, Struct, Enum, Closure 다 사용가능
    func anyvsAnyObject() {
        let name = "고래밥"
        let gender = false
        let age = 10
        let characters = Game()
        
        let anyList: [Any] = [name, gender, age, characters]
        let anyObjectList: [AnyObject] = [characters]
        print(anyObjectList.capacity)
        print(anyList)
        
        if let value = anyList[0] as? String {
            print(value)
        }
    }
    
    // 컴파일 상황에서 알 수 없고, 런타임 시점에서 버튼타입인지 확인할 수 있다.
    @IBAction func buttonClicked(_ sender: UIButton) {
        print(sender.currentTitle)
    }
    
    //
    func copyOnWrite() {
        // Struct 값. 복사
        // 우리가 앱을 실행해보면
//        var nickname = "jack"
//        print(address(of: nickname))
//        var nicknameByFamily = nickname
//        print(address(of: nicknameByFamily))
//
//        nicknameByFamily = "꽁"
//        print(address(of: nicknameByFamily))
//        print(nickname, nicknameByFamily)
        
        var array = Array(repeating: 100, count: 100)
        print(address(of: &array))
        var newArray = array
        print(address(of: &newArray))
        newArray[0] = 0
        print(address(of: &newArray))
        
        
        var game = Game()
        print(address(of: &game))
        var newGame = game
        newGame.level = 595
        print(address(of: &newGame))
        print(game.level, newGame.level)
    }
    
    func address(of object: UnsafeRawPointer) -> String {
        let address = Int(bitPattern: object)
        return String(format: "%p", address)
    }
    
    // CollectionType: Collection, Sequence, Subscript
    func aboutSubScript() {
        let array = [1, 2, 3, 4, 5]
        array[2]
        
        let dic = ["도사": 595, "도적": 594]
        dic["도사"]
        
        let str = "Hello World"
        print(str[2])
        print(str[8])
        
        
        struct UserPhone {
            var numbers = ["01012345678", "01023456789", "01034567890"]
            
            subscript(idx: Int) -> String {
                get {
                    return self.numbers[idx]
                }
                set {
                    self.numbers[idx] = newValue
                }
            }
        }
        
        var value = UserPhone()
        print(value.numbers[0])
        print(value[0])
        print(value[1] = "1234")
    }
    
    func aboutForEach() {
        let array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        
        for i in array {
            print(i)
            
            if i == 5 {
                break
            }
            
        }
        
        array.forEach { value in
            print(value)
            return
        }
    }
    
//    var bool = Optional.none
//    
//    switch bool {
//    case .none:
//        <#code#>
//    case .some(let wrapped):
//        <#code#>
//    @unknown default:
//        print("test")
//    }
    
    // 라이브러리, 프레임워크 단위로 올라갔을 때 도움이 되는 거라고 보면 된다.
    // @frozen
    // Unfrozen Enumeration: 계속 추가될 수 있는 가능성을 가진 열거형
    func aboutEnum() {
//        let size = UIUserInterfaceSizeClass.compact
//
//        switch size {
//        case .unspecified:
//            <#code#>
//        case .compact:
//            <#code#>
//        case .regular:
//            <#code#>
//        @unknown default:
//            <#fatalError()#>
//        }
    }
}

extension String {
    subscript(idx: Int) -> String? {
        guard (0..<count).contains(idx) else {
            return nil
        }
        let result = index(startIndex, offsetBy: idx)
        return String(self[result])
    }
}
