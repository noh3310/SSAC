import UIKit

//if Calendar.current.compare(Date(, to: Date() + 80000, toGranularity: .day) == .orderedAscending {
//    print("같음")
//} else {
//    print("다름")
//}
let today = Date()
let weekday = Calendar.current.component(.weekday, from: today)

let tomorrow = Calendar.current.date(byAdding: .day, value: -1, to: today)!
let weekday2 = Calendar.current.component(.weekday, from: tomorrow)

print(weekday)
