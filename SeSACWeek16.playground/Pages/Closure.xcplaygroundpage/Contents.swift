//: [Previous](@previous)

import Foundation

//func makeIncrementer(forIncrementer amount: Int) -> () -> Void {
//
//    var runningTotal = 0
//
//    // 중첩 함수
//    func incrementer() -> Int {
//        runningTotal += amount // runningTotal, amount 내부적으로 저장하고 있음 => 캡쳐
//        return runningTotal
//    }
//
//    return incrementer
//}
//
//var incrementByTen = makeIncrementer(forIncrementer: 10) // incrementByTen -> incrementer
//
//incrementByTen()
//incrementByTen()
//incrementByTen()

func firstClosure() {
    var number = 0
    print("1: \(number)")
    
    // number를 내부적으로 저장(캡처)하고 있음 = 복사
    // 구조체, 값, 복사 -> 클래스처럼 참조가 되는 형태로 캡처가 되고 있다.
    // => 클로저: 무조건 캡처를 참조타입으로 캡처한다. => 이것을 Reference Capture를 한다라고 표현을 하고 있다.
    // [number] 복사해서 사용할 수 있고, 외부와 독립적인 형태로 값을 사용할 수 있지만 "상수"로 캡처된다.
    let closure: () -> Void = { [number] in
//        number = 50
        print("closure: \(number)")
    }
    
    closure()
//    number = 100
    print("2: \(number)")
}

firstClosure()

class User {
    var nickname = "jack"
    
    // [weak self] 두개를 써서 약한참조를 하겠다
    // 즉 참조하더라도 참조 카운트가 증가하지 않도록 하겠다.
    lazy var introduce: () -> String = { [weak self] in
        guard self = self else { return }
        
        return self.nickname ?? ""
    }
    
    deinit {
        print("User Deinit")
    }
}

var nickname: User? = User()

nickname?.introduce

nickname = nil




//: [Next](@next)
