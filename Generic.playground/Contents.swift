import UIKit

// code에서
// Swift가 타입에 민감해서 조금만 달라져도 뭐라하는데 제네릭을 쓰면 편안...


var apple = 8
var banana = 3

//print(apple, banana)
//// inout parameter(inout 매개변수)
//swap(&apple, &banana)
//
//print(apple, banana)

func swapTwoInts(a: inout Int, b: inout Int) {
    print("swapTwoInt")
    let tempA = a
    a = b
    b = tempA
}

print(apple, banana)
swapTwoInts(a: &apple, b: &banana)
print(apple, banana)

func swapTwoValues(_ a: inout Double, _ b: inout Double) {
    print("swapTwoDouble")
    let tempA = a
    a = b
    b = tempA
}

func swapTwoString(a: inout String, b: inout String) {
    print("swapTwoString")
    let tempA = a
    a = b
    b = tempA
}

// 위에처럼 swap을 여러개계속 써야한다. 비효율적이게 된다.

// Jack: 타입 파라미터(Type Parameter) - 함수 정의 시 타입을 선언하지 않고, 함수 호출 시 매개변수 타입으로 대체되는 placeholder
// 항상 대문자로 쓰는것을 권장한다.
func swapTwoValues<T>(_ a: inout T, _ b : inout T) {
    print("swapTwoValues")
    let tempA = a
    a = b
    b = tempA
}

var fruit1 = 3.3
var fruit2 = 6.6

print(fruit1, fruit2)
swapTwoValues(&fruit1, &fruit2)
print(fruit1, fruit2)

// 오버로딩 - 이름이 같고 매개변수의 수, 순서, 타입이 다른 함수를 계속 선언할 수 있다.


//func total(a: [Int]) -> Int {
//    return a.reduce(0, +)
//}
//
//func total(a: [Double]) -> Double {
//    return a.reduce(0, +)
//}
//
//func total(a: [Float]) -> Float {
//    return a.reduce(0, +)
//}

// Generic 함수
// 프로토콜 제약
//func total<T: Numeric>(a: [T]) -> T {
//    // Int, String, Dictonary, Float, Class, Struct 전부다 들어갈 수 있다.
//    return a.reduce(.zero, +)
//}

//total(a: ["아", "니", "오"])

// 더하거나 뺄 수 있는 부분을 설정할 수 있다.
//func total<T: AdditiveArithmetic>(a: [T]) -> T {
//    // Int, String, Dictonary, Float, Class, Struct 전부다 들어갈 수 있다.
//    return a.reduce(.zero, +)
//}
//total(a: ["아", "니", "오"])

// navigation
struct Stack<T> {
    var items = [T]()
    
    mutating func push(_ item: T) {
        items.append(item)
    }
    
    mutating func pop() -> T {
        return items.removeLast()
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("안")
stackOfStrings.push("녕")
stackOfStrings.push("하")
stackOfStrings.push("세")
stackOfStrings.push("요")

print(stackOfStrings.pop())

extension Stack {
    var topElement: T? {
        return self.items.last
    }
}

print(stackOfStrings.topElement!)

// Equtable을 사용해보라고 하심
// 나는 Comparable을 사용함 ㅋㅋㅋㅋㅋ
func equal<T: Equatable>(a: T, b: T) -> Bool {
    return a == b
}

equal(a: 2, b: 2)

class Animal: Equatable {
    static func == (lhs: Animal, rhs: Animal) -> Bool {
        return lhs.name == rhs.name
    }
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

let one = Animal(name: "고양이")
let two = Animal(name: "고양이")

one == two


class Dog: Animal {
    
}

class Cat {
    
}

// 화면전환
import UIKit

class ViewController: UIViewController {
    func transitionViewController<T: UIViewController>(sb: String, vc: T) {
        let sb = UIStoryboard(name: sb, bundle: nil)
        let nvc = sb.instantiateViewController(withIdentifier: vc.self) as! T
        
        self.present(nvc, animated: true, completion: nil)
    }
}


