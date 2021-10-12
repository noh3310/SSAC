import UIKit

func check(number: Int?) {
    guard let checkNumber = number else {
        print("no number")
        return
    }
    print("number is \(checkNumber)")
}

let number: Int? = Optional.some(42)
let noNumber: Int? = Optional.none

check(number: number)
check(number: noNumber)





//if let checkNumber = number {
//    print("number is \(checkNumber)")
//}
//else {
//    print("no number")
//}
//
//print(checkNumber)

//guard let checkNumber = number else {
//    print("no number")
//}
