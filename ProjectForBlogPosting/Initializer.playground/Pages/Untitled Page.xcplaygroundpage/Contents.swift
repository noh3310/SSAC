import Foundation
import UIKit

class User {
    var name: String = ""
    var age: Int = 0
    
//    init(name: String, age: Int) {
//        self.name = name
//        self.age = age
//    }
}

struct UserStruct {
    var name: String = ""
    var age: Int = 0
}

// extension으로 두개를 묶을 수 있다.
extension UserStruct {
    init(age: Int) {
        self.name = "손님"
        self.age = age
    }
}

// 인스턴스를 만들 때 저장 프로퍼티에 대한 모든 값은 초기화되어야한다.
let a = User()  // 초기화 구문, 초기화 메서드 -> Default initializer
let b = UserStruct(name: "", age: 0) // 멤버와이즈 초기화언어
let c = UserStruct() // 저장프로퍼티가 초기화되어있기 때문에 별도로 초기화하지 않아도 된다.
let d = UserStruct(age: 22) // 익스텐션으로 추가해줌



// 아래 두가지 코드는 같은 의미를 가진다.
let color = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
// init()과 같이 초기화 메서드를 생략할 수 있었다.
let color2 = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)



// 편의 생성자 convenience initializer
class Coffee {
    let shot: Int
    let size: String
    let menu: String
    let mind: String
    
    // Designated initializer
    init(shot: Int, size: String, menu: String, mind: String) {
        self.shot = shot
        self.size = size
        self.menu = menu
        self.mind = mind
    }
    
    // 기본(2, tall)
    convenience init(value: String) {
        // 나머지가 기본값이 들어갈 수 있을 떄 쓸 수 있다.
        self.init(shot: 2, size: "tall", menu: value, mind: "기본")
    }
}

let coffee = Coffee(shot: 2, size: "크게", menu: "아아", mind: "정성듬뿍")
// convenience initializer를 사용해서 생성한다.
let coffee2 = Coffee(value: "아메리카노")


// 익스텐션을 사용해서 편하게 쓸 수 있음
extension UIColor {
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}


let customColor = UIColor(red: 28, green: 12, blue: 205)

// 프로포콜 초기화 구문: 프로퍼티, 메서드, 초기화구문 정의 가능
// 초기화 구문은 함수처럼 사용되서 초기화 메서드라고도 한다.
// 프로토콜은 초기값이 들어가지 않고, 형태만 들어간다.
protocol Jack {
    // 초기화도 프로토콜에서 설정할 수 있음
    init()
}

// hello 클래스에 init이 있는것과 구분하기 위해서 사용된다.
//class Hello: Jack {
//    var name: String = ""
//
//    required init() {
//
//    }
//
//    func welcome() {
//        print("")
//    }
//}
//
// -------------------------------------
//class HelloBrother: Hello {
//
//    required init() {
//
//    }
//}
// -------------------------------------
class Hello {
    init() {
        print("Hello")
    }
}

class HelloBrother: Hello, Jack {
    
    // 프로토콜의 요구사항도 지키면서 Hello의 요구사항도 지키게 된다.
    required override init() {
        super.init()
        print("HelloBrother")
    }
}

var hello = HelloBrother()


// 초기화 구문 델리게이션

class A {
    var value: Int
    
    init() {
        self.value = 10
    }
}

// 만약 여기서 super.init을 안해주면 A가 불려지지 않아서 오류가 발생할 것이다.
class B: A {
    override init() {
        super.init()
        print("B")
    }
}

class C: B {
    override init() {
        super.init()
    }
    
    // 메모리에서 사라지는 부분
    deinit {
        print("deinit")
    }
}

var test: C? = C()
test = nil


