import UIKit

class FilePrivateClass {
    fileprivate var filePrivateNumber: Int
    
    init() {
        filePrivateNumber = 0
    }
    
    func add() {
        filePrivateNumber += 1
    }
}

class PrivateClass {
    private var privateNumber: Int
    
    init() {
        privateNumber = 0
    }
    
    func add() {
        privateNumber += 1
    }
}

let filePrivateClass = FilePrivateClass()
filePrivateClass.filePrivateNumber = 1

let privateClass = PrivateClass()
privateClass.privateNumber = 1




