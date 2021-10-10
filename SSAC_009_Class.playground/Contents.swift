import UIKit

// 함수 매개변수 반환값

// 매개변수를 사용하지 않는 함수
func sayHello() -> String {
    print("hello")
    
    return "안녕하세요 반갑습니다"
}

print(sayHello())


func bmi() -> Double {
    return 20.1
}

func bmiResult() -> [String] {
    let name = "고래밥"
    let result = "정상"
    
    return [name, result]
}

let value = bmiResult()

print(value[0] + "님의 BMI 지수는 " + value[1] + "입니다.")


// 컬렛견(집단 자료형): 배열, 딕셔너리, 집합 + 튜플
let userInfo = ("고양이", "jack@gmail.com", true, 4.5)

userInfo.0
userInfo.1
userInfo.2
userInfo.3

// 전체 영화 갯수, 전체 러닝타임
func getMovieReport() -> (Int, Int) {
    return (1000, 30000)
}


// Swift 5.1로 업데이트되면서 생긴 것 - return을 생략할 수 있음
func getMovie() -> (Int, Int) {
    (1000, 20000)
}

//@discardableResult: 반환값을 무시하는 기능을 구현하고 싶을 때 사용
@discardableResult func a() -> Int {
    return 0
}

a()

// 열거형(Enum)
enum AppDevice {
    case iPhone
    case iPad
    case Watch
}

enum GameJob: String{
    case rouge = "도적"
    case warrior = "전사"
    case mystic = "도사"
    case shaman = "주술사"
    case fight = "격투가"
}

let selectJob = GameJob.fight
print("당신은 ", selectJob, "입니다")

selectJob.rawValue

// 아래처럼 case를 한줄에 표현해줘도 된다.
enum Gender {
    case man, woman
}

if selectJob == .fight {
    print("당신은 격투가입니다.")
}
else if selectJob == .shaman {
    print("당신은 주술사입니다.")
}

switch selectJob {
    case .shaman: print("주술사")
    case .warrior: print("전사")
    default: break
}


enum HTTPCode: Int {
    case OK = 200
    case SERVER_ERROR = 500
    case NO_PAGE = 401
    
    func showStatus() -> String {
        switch self {
        case .NO_PAGE:
            return "잘못된 주소입니다."
        case .SERVER_ERROR:
            return "서버 점검중입니다."
        case .OK:
            return "정상입니다."
        default:
            return "default"
        }
    }
}

var status = HTTPCode.OK

print(status.rawValue)  // 원시값
print(status.showStatus())

if status == .NO_PAGE {
    print("잘못된 주소입니다")
}
else if status == .SERVER_ERROR {
    print("서버 점검중입니다. 서버에 문제가 생겨서 잡시 후 시도해주세요.")
}

