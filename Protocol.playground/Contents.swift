import UIKit

//// Protocol: 클래스, 구조체 청사진....
//// 몇가지 케이스를 작성해보겠다.
//
//// 클래스의 경우 단일상속밖에 안된다.
//// 프로토콜을 만들어보겠다.
//// 실질적인 구현은 하지 않는다.
//// 구현해야 하는 "기능"에 집중한다.
//// 특정 뷰객체
//
//// 프로토콜 메서드 개념의 일종
//protocol OrderSystem {
//    func recommandEventMenu()
//    func askStampCard(count: Int) -> String
//}
//
//class StarBucksMenu {
//
//}
//
//class Smoothie: StarBucksMenu, OrderSystem {
//    func recommandEventMenu() {
//        print("스무디 이벤트 인내")
//    }
//
//    func askStampCard(count: Int) -> String {
//        return "\(count)잔 적립 완료"
//    }
//
//
//}
//
//class Coffee: StarBucksMenu, OrderSystem {
//    func recommandEventMenu() {
//        print("커피 베이큰 이벤트 인내")
//    }
//
//    func askStampCard(count: Int) -> String {
//        return "\(count * 2)잔 적립 완료"
//    }
//
//
//}
//
//
//// 프로토콜 프로퍼티: 타입과 get, set만 명시, 연산 프로퍼티/ 저장 프로퍼티는 상관 없음
//protocol NavigationUIPaorocol {
//    // 읽기 전용으로 쓸지 쓰기 전용으로 쓸지 설정
//    var titleString: String { get set }
//    var mainTintColor: UIColor { get }
//
//}
//
//class ViewController: UIViewController, NavigationUIPaorocol {
//
//    var titleString: String = "나의 일기"
//    var mainTintColor: UIColor = .black // 얘는 왜 get만 했는데 변수 설정이 가능한가?
//    // get만 사용한 경우에는 get은 필수고, set은 선택이다.
//    // get이랑 set을 선언해놓음녀 둘다 선언해야하고
//    // get만 선언해놓으면 get은 선언해야하고, set은 선언안해도된다.
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        title = titleString
//        view.backgroundColor = mainTintColor
//
//
//    }
//}
//
//// 프로토콜 변수를 연산 프로퍼티로 사용하는 예
//class JViewController: UIViewController, NavigationUIPaorocol {
//
//    var titleString: String {
//        get {
//            return "나의 일기"
//        }
//        set {
//            // 아래처럼 네비게이션 타이틀을 이렇게 설정할 수 있음
//            navigationTitle = newValue
//        }
//    }
//    var mainTintColor: UIColor {
//        get {
//            return .black
//        }
//        // set은 선택사항
//        set {
//            view.backgroundColor = newValue
//        }
//    }
//
//    //만약 get만 쓴다면 위의 변수를 아래처럼 간단하게 작성할 수 있음
//    var mainTintColor: UIColor {
//        return .black
//    }
//
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        titleString = "새로운 일기"
//
//
//    }
//}


// 연산 프로퍼티
struct SeSacStucent {
    var totalCount = 50
    
    var currentStudent = 0
    
    var studentUpdate: String {
        get {
            return "\(totalCount - currentStudent)명 남았습니다."
        }
        set {
            currentStudent += Int(newValue) ?? 0
        }
    }
}

var ssac = SeSacStucent()

// set 연산
ssac.studentUpdate = "10"
// get 연산
ssac.studentUpdate


// 프로토콜 메서드 개념의 일종
// 프로토콜에서 init이 있다면 구조체의 멤버와이즈 구문 대신 새로운 init을 꼭 써줘야함
// 만약 프로토콜을 반드시 클래스에서만 사용할 수 있도록 하려면
// AnyObject을 쓰면 반드시 클래스에서만 사용가능하다.
@objc
protocol OrderSystem: AnyObject {
    func recommandEventMenu()
    @objc optional func askStampCard(count: Int) -> String // 옵셔널로 초기화를 하면 무조건 구현하지 않아도 된다.
    //init()// 초기화 구문: 구조체가 멤버와이즈 구문이 있더라도 반드시 선언해야함
    // 클래스 같은 경우, 부모 클래스에 초기화 구문과 프로토콜의 초기화 구문이 구별, 명시
}

class StarBucksMenu {

}

class Smoothie: StarBucksMenu, OrderSystem {
    
    let smoothie = Smoothie() // is
    
    func text() {
        smoothie is Coffee
        smoothie is StarBucksMenu
        smoothie is OrderSystem // 특이하게도 프로토콜과도 비교가 가능하다
        // 상속받은 프로토콜로 형변환이 가능하다.
    }
    
    func recommandEventMenu() {
        print("스무디 이벤트 인내")
    }

    func askStampCard(count: Int) -> String {
        return "\(count)잔 적립 완료"
    }
    
//    init() {
//
//    }


}

class Coffee: StarBucksMenu, OrderSystem {
    func recommandEventMenu() {
        print("커피 베이큰 이벤트 인내")
    }

    func askStampCard(count: Int) -> String {
        return "\(count * 2)잔 적립 완료"
    }

//    init() {
//
//    }
}

// 하나 빼먹은것에 대해서 말해보겠습니다.
