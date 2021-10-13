import UIKit
import Security
import Foundation

//// 옵셔널 바인딩: if - lef, guard let
//enum UserMissionStatus: Int {
//    case missionFailed
//    case missionComplete
//}
//
//check1(number: Optional<Int>(1))
//check2(number: Optional<Int>(1))
//
//func check1(number: Int?) -> (UserMissionStatus, Int?) {
//    if let checkNumber = number {
//        return (.missionComplete, checkNumber)
//    }
//    else {
//        return (.missionFailed, nil)
//    }
//}
//
//
//func check2(number: Int?) -> (UserMissionStatus, Int?) {
//    guard number != nil else {
//        return (.missionFailed, nil)
//    }
//    return (.missionComplete, number)
//}

// 타입 캐스팅은 여러분이 찾아보시는것을 추천드려용
// Any라는 타입이 들어가게 될 것입니다.
// 타입 캐스팅: 메모리의 인스턴스 타입은 바뀌지 않는다.
//let array = [1, true, "hello"] as [Any]
//
//let arrayInt = array as? [Int]
//print(arrayInt)

class Mobile {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

class AppleMobile: Mobile {
    var company = "애플"
}

class GoogleMobile: Mobile {
    
}

let mobile = Mobile(name: "핸드폰")
let iphone = AppleMobile(name: "아이폰")
let googlePhone = GoogleMobile(name: "구글폰")

// is 라는것이 있음(as와 유사함)
mobile is Mobile
mobile is AppleMobile
mobile is GoogleMobile

iphone is Mobile
iphone is AppleMobile
iphone is GoogleMobile

googlePhone is Mobile
googlePhone is AppleMobile
googlePhone is GoogleMobile

var iPad: Mobile = AppleMobile(name: "아이패드")
iPad is Mobile
iPad is AppleMobile
//iPad.company

// as, as?, as! 3가지에 대해서 알아보기
if let value = iPad as? AppleMobile {
    print("성공", value.company)
}

// 클래스, 구조체
enum DrinkSize {
    case short, tall, grande, venti
}

struct DrinkStruct {
    let name: String
    var count: Int
    var size: DrinkSize
}

class DrinkClass {
    let name: String
    var count: Int
    var size: DrinkSize
    
    init(name: String, count: Int, size: DrinkSize) {
        self.name = name
        self.count = count
        self.size = size
    }
}

var drinkStruct = DrinkStruct(name: "아메리카노", count: 3, size: .tall)
drinkStruct.count = 2
drinkStruct.size = .venti
print(drinkStruct.name, drinkStruct.count, drinkStruct.size)


let drinkClass = DrinkClass(name: "블루베리 스무디", count: 2, size: .venti)
drinkClass.count = 4
drinkClass.size = .tall

print(drinkClass.name, drinkClass.count, drinkClass.size)


// 지연 저장 프로퍼티
// lazy를 써주면 처음에 저장되는것이 아니라 나중에 저장됨
// 메모리를 나중에 로드해야 할 때 사용할 수 있을 것임
// 지연저장 프로퍼티의 특성: 변수 저장 프로퍼티, 초기화
struct Poster {
    var image: UIImage = UIImage(systemName: "star") ?? UIImage()
    
    init() {
        print("Poster Initialized")
    }
}

struct MediaInformation {
    var mediaTitle: String
    var mediaRuntime: Int
    lazy var mediaPoster: Poster = Poster()
}

var media = MediaInformation(mediaTitle: "오징어게임", mediaRuntime: 333)
print("1")
media.mediaPoster
print("2")


// 연산 프로퍼티 && 프로퍼티 감시자(옵저버) => Swift 5.1에서 PropertyWrapper에서 사용됨 (@State, @Environment에 대해서 알아보면 좋을듯)
// 프로퍼티 감시자는 프로퍼티가 바뀌는지 계속 확인하는 것
// 타입 알리어스
class BMI {
    typealias BMIValue = Double
    
    var userName: String {
        // 프로퍼티 감시자
        willSet {
            // 바뀔 내용이 아직 변수에 할당되지 않음
            print("닉네임 변경 예정: \(userName) -> \(newValue) 바뀔 예정입니다.")
        }
        didSet {
            changeNameCount += 1
            // 바뀔 내용이 변수에 할당됨
            // 이전 값은 oldValue임
            print("닉네임이 \(oldValue) -> \(userName) 바뀌었습니다.")
        }
    }
    var changeNameCount = 0
    
    var userWeight: BMIValue
    var userHeight: BMIValue
    
    var BMIResult: String {
        // set 혼자는 사용할 수 없고
        // get혼자는 사용할 수 있고, get set둘다는 사용할 수 있음
        get {
            let bmiValue = (userHeight * userWeight) / userHeight
            let bmiStatus = bmiValue < 18.5 ? "저체중" : "정상"
            return "\(userName)님의 BMI 지수는 \(bmiValue)로 \(bmiStatus) 입니다."
        }
        // 값을 수정해주고 싶을때는 set을 써준다
        set(nickname) {
//            userName = newValue
            userName = nickname
        }
    }
    
    init(userName: String, userWeight: Double, userHeight: Double) {
        self.userName = userName
        self.userWeight = userWeight
        self.userHeight = userHeight
    }
}

let bmi = BMI(userName: "나다", userWeight: 50, userHeight: 160)
bmi.BMIResult
print("1")
bmi.BMIResult = "Minsu1"
bmi.changeNameCount
bmi.BMIResult = "Minsu2"
bmi.changeNameCount
bmi.BMIResult = "Minsu3"
bmi.changeNameCount
print("2")
bmi.BMIResult


