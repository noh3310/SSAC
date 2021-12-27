import UIKit

//open class OpenClass {
//    open var openValue = 0  // open
//    public var publicValue = 0  // public
//    internal var internalValue = 0  // internal
//    fileprivate var fileprivateValue = 0    // fileprivate
//    private var privateValue = 0    // private
//
//    var iDontKnowAccessLevel = 0    // internal
//
//    init() {
//
//    }
//}
//
//public class PublicClass {
//    public var publicValue = 0  // public
//    internal var internalValue = 0  // internal
//    fileprivate var fileprivateValue = 0    // fileprivate
//    private var privateValue = 0    // private
//
//    var iDontKnowAccessLevel = 0    // internal
//    init() {
//
//    }
//}
//
//internal class InternalClass {
//    internal var internalValue = 0  // internal
//    fileprivate var fileprivateValue = 0    // fileprivate
//    private var privateValue = 0    // private
//
//    var iDontKnowAccessLevel = 0    // internal
//    init() {
//
//    }
//}
//
//fileprivate class FileprivateClass {
//    fileprivate var fileprivateValue = 0    // fileprivate
//    private var privateValue = 0    // private
//
//    var iDontKnowAccessLevel = 0    // fileprivate
//    init() {
//
//    }
//}
//
//private class PrivateClass {
//    private var privateValue = 0    // private
//
//    var iDontKnowAccessLevel = 0    // private
//    init() {
//
//    }
//}
//
////let value = (OpenClass(),
////             PublicClass(),
////             InternalClass(),
////             FileprivateClass(),
////             PrivateClass())
//
//
//public class A {
//    fileprivate func someFunction() {
//        print("function")
//    }
//}
//
//internal class B: A {
//    public override func someFunction() {
//        super.someFunction()
//        print("override Function")
//    }
//}
//
//private func function() -> (A, B) {
//    return (A(), B())
//}
//
//public enum Arrow {
//    case up // public
//    case down // public
//    case left // public
//    case right // public
//}

//// 올바른 사용방법
//public private(set) var number1 = 0
//
//// get이 set보다 접근레벨이 낮기때문에 사용할 수 없음
//internal public(set) var number2 = 0
//
//// public(get) -> public으로 변경해야함
//public(get) private(set) var number3 = 0
//
//
//
//public class InternalClass {
//    public private(set) var number = 0
//
//    func setNumber(_ number: Int) {
//        self.number = number
//    }
//}
//
//var internalClass = InternalClass()
//internalClass.setNumber(10)
//internalClass.number
//internalClass.number = 10   // error


//class SomeClass {
//    var name: String?
//    var age = 10
//}
//
//let someClass = SomeClass()
//
//
//struct SomeStruct {
//    var name: String
//    private var age: Int
//
//    init(name: String, age: Int) {
//        self.name = name
//        self.age = age
//    }
//}
//
//let someStruct = SomeStruct(name: "name", age: 10)

public protocol publicProtocol {}
private typealias publicValue = publicProtocol

private protocol privateProtocol {}
public typealias privateValue = privateProtocol





private protocol SomeProtocol {
    func someFunction()
}

public class SomeClass {
}

fileprivate extension SomeClass: SomeProtocol {
    func someFunction() {
        print("function")
    }
}



class ChildClass: SomeClass {
    override func someFunction() {
        print("childFunction")
    }
}

//private protocol SuperProtocol {
//}
//
//protocol ChildProtocol: SuperProtocol {
//}


//open class OpenClass {
//    open var openNumber = 0
//}
//
//public class PublicClass {
//    public var publicNumber = 0
//}
//
//internal class InternalClass {
//    internal var internalNumber = 0
//}
//
//fileprivate class FileprivateClass {
//    fileprivate var FileprivateNumber = 0
//}
//
//private class PrivateClass {
//    private var privateNumber = 0
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//class FilePrivateClass {
//    fileprivate var filePrivateNumber: Int
//
//    init() {
//        filePrivateNumber = 0
//    }
//
//    func add() {
//        filePrivateNumber += 1
//    }
//}
//
//class PrivateClass {
//    private var privateNumber: Int
//
//    init() {
//        privateNumber = 0
//    }
//
//    func add() {
//        privateNumber += 1
//    }
//}
//
//let filePrivateClass = FilePrivateClass()
//filePrivateClass.filePrivateNumber = 1
//
//let privateClass = PrivateClass()
//privateClass.privateNumber = 1
//
//
//
//
