import UIKit

class A {
    static func a() {   // 타입 메서드는 Static Dispatch 상태가 된다.
        
    }
    
    class func b() {    // 타입 메서드이지만 오버라이딩이 가능해서 Dynamic이다.
        
    }
    
    final class func bb() {    // final class는 static과 같기 때문에 Static Dispatch 상태가 된다.
        
    }
    
    func c() {  // 인스턴스 메서드
        
    }
}



//struct EndPoint {
//    static let baseURL = "http://test.monocoding.com/"
//
//    static let signup = baseURL + "auth/local/register"
//    static let login = baseURL + "auth/local"
//    static let board = baseURL + "board"
//}

//enum EndPoint {
//    case signup
//    case login
//    case boards
//    case boardDetail(id: Int)
//}
//
//extension EndPoint {
//    var url: URL {
//        switch self {
//        case .signup:
//            return .makeEndpoint("auth/local/register")
//        case .login:
//            return .makeEndpoint("auth/local")
//        case .boards:
//            return .makeEndpoint("boards")
//        case .boardDetail(id: let id):
//            return .makeEndpoint("board/\(id)")
//        }
//    }
//}
//
//extension URL {
//    static let baseURL = "http://test.monocoding.com"
//
//    static func makeEndpoint(_ endpoint: String) -> URL {
//        return URL(string: baseURL + endpoint)!
//    }
//
//    // 로그인 주소를 리턴해줌
//    static var login: URL {
//        return makeEndpoint("auth/local")
//    }
//
//    static var signup: URL {
//        return makeEndpoint("auth/local/register")
//    }
//
//    static var boards: URL {
//        return makeEndpoint("boards")
//    }
//
//    static func boardsDetail(number: Int) -> URL {
//        makeEndpoint("boards/\(number)")
//    }
//}
//
//// 두개 호출하는것은 같은 작업을 수행함
//URLSession.shared.dataTask(with: EndPoint.signup.url)
//URLSession.shared.dataTask(with: .login)
//print(EndPoint.signup.url)


/*
 boards: 게시물, detail
 
 */


//class Observable<T> {
//    // 옵셔널로 init 만들어줌
//    private var listener: ( (T) -> Void )?
//
//    // listener에 value를 전해줌
//    var value: T {
//        didSet {
//            listener?(value)
//        }
//    }
//
//    init(_ value: T) {
//        self.value = value
//    }
//
//    func bind(_ closure: @escaping (T) -> Void) {
//        closure(value)
//        listener = closure
//    }
//}
//
//class User<T> {
//
//    var listener: ( (T) -> Void )?
//
//    var name: T {
//        didSet {
//            listener?(name)
//        }
//    }
//
//    init(id name: T) {
//        self.name = name
//    }
//
//    func changeName(_ completion: @escaping (T) -> Void) {
//        completion(name)
//        listener = completion
//    }
//}
//
//let usr = User(id: "고래밥")
//usr.name = "칙촉"
//
//
//let jack = User(id: "jack")
//
//let value = Observable(0)
//
//jack.name = "칙촉"
//
//
//func hello(name: String, age: Int) -> String {
//    return "\(name): \(age)"
//}
//
//let a = hello(name: "고래밥", age: 2)
//type(of: a)
//
//// 함수만 담으면 b의 형태는 hello가 실행되지 않고, 함수 타입만을 담았기 때문에 (String, Int) -> String 타입이 된다.
//let b: (String, Int) -> String = hello
//type(of: b)
//
//b("칙촉", 33)
//
//var hello: String?
//var listener: ( () -> Void )?
//
//func test() {
//
//}
//
//type(of: test)
//type(of: listener)
