import UIKit

// 선언만 해두고 실제로 사용하는 것은
protocol Introduce {
    var name: String { get set }
    var age: Int { get }
    
    func introduce()
}

class Human {
    
}

class Jack: Human, Introduce {
    var name: String = "Jack"
    var age: Int = 10
    
    func introduce() {
        print("자기소개 하기")
    }
}
