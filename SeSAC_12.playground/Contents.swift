import UIKit

// static에 대해 배워보겠음!
// 타입 프로퍼티에 대해 알아보겠다.
// 지난번에는 연산 프로퍼티랑 저장 프로퍼티를 배웠다.

class User {
    static let nickname = "Alice"
    
    static var totalOrderCount = 0 {
        didSet {
            print("총 주문 횟수: \(oldValue)에서 \(totalOrderCount)로 증가")
        }
    }
    
    static var orderProduct: Int {
        get {
            return totalOrderCount
        }
        set {
            totalOrderCount += newValue
        }
    }
}

let user = User()

User.nickname
User.orderProduct = 10
User.orderProduct

User.orderProduct = 10

// 인스턴스를 활용했을때 메서드가 어떻게 달라지는지 보겠다.
class Point {
    var x = 0.0
    var y = 0.0
    
    func moveBy(x: Double, y: Double) {
        self.x += x
        self.y += y
    }
}

var somePoint = Point()
print("Point: x = ", somePoint.x, ", y = ", somePoint.y)
somePoint.moveBy(x: 1, y: 2)
print("Point: x = ", somePoint.x, ", y = ", somePoint.y)


// 인스턴스 메서드: 구조체에서 자신의 프로퍼티값을 인스턴스 메서드 내에서 변경하게 될 경우 mutating
struct PointStruct {
    var x = 0.0
    var y = 0.0
    
    // 인스턴스 메서드에서 mutatate가 중요한 부분이다.
    mutating func moveBy(x: Double, y: Double) {
        self.x += x
        self.y += y
    }
}

var somePointStruct = PointStruct()
print("Point: x = ", somePointStruct.x, ", y = ", somePointStruct.y)
somePointStruct.moveBy(x: 1, y: 2)
print("Point: x = ", somePointStruct.x, ", y = ", somePointStruct.y)


// 타입 메서드를 알아볼 예정이다.

class Coffee {
    static var name = "아메리카노"
    static var shot = 2
    
    static func pluseShot() {
        shot += 1
    }
    
    class func minusShoot() {
        shot -= 1
    }
    
    func hello() {
        print("hello")
    }
}

// static은 상속했을 때 오버라이딩 할 수 없다.
// 상속을 해서 오버라이딩 하고싶으면 static대신 class를 쓰면 된다.
class Latte: Coffee {
    override func hello() {
        print("Latte")
    }
    
    override class func minusShoot() {
        print("타입 메서드를 상속받아 재정의 하고 싶은 경우, 부모 클래스에서 타입 메서드를 선언할 때 static 아니라 class를 쓰면 재정의 할 수 있다.")
    }
}

let coffee = Coffee()

// 싱글톤으로 사용해보겠다.
// 프로퍼티 wrapper가 있다.
class UserDefaultHelper {
    
    // 자기 자신의 인스턴스를 담아버린다.
    static let shared = UserDefaultHelper()
    
    let userDefaults = UserDefaults.standard
    
    enum Key: String {
        case nickname, age, rate
    }
    
    // 처음에는 nil값이므로 물음표를 붙여줌
    var userNickname: String? {
        get {
            return userDefaults.string(forKey: Key.nickname.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.nickname.rawValue)
        }
    }
    
    var userAge: Int? {
        get {
            return userDefaults.integer(forKey: Key.age.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.age.rawValue)
        }
    }
    
    // 이것을 안쓰면 인스턴스를 선언해서 값을 변경할 수 있기 때문에 이 처리를 해줘야된다고 함
    private init() {
        
    }
}

UserDefaultHelper.shared.userNickname
UserDefaultHelper.shared.userAge

UserDefaultHelper.shared.userNickname = "11"
UserDefaultHelper.shared.userAge = 12

UserDefaultHelper.shared.userNickname = "11"
UserDefaultHelper.shared.userAge = 12


