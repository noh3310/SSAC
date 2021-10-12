import UIKit

enum FastFoodMenuItem {
    case hambuger(numberOfPatties: Int)
    case fries(size: FryOrderSize)
    case drink(String, ounces: Int)
    case cookie
    
    func isIncludedInSpecialOrder(number: Int) -> Bool {
        switch self {
            case .hambuger(let pattyCount): return pattyCount == number
            case .fries, .cookie: return true
            case .drink(_, let ounces): return ounces == 16
        }
    }
}

enum FryOrderSize {
    case large
    case small
}

var menuItem = FastFoodMenuItem.hambuger(numberOfPatties: 2)
var isSpecialOrder = menuItem.isIncludedInSpecialOrder(number: 2)

if isSpecialOrder { print("스페셜 주문입니다.") }
else { print("스페셜 주문이 아닙니다.") }


