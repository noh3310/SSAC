import UIKit

struct Animal {
    var age: Int
    var name: String
    var live: String
}

struct Cat : Animal {
    var sleepTime: Int
        init(age: Int, name: String, live: String, sleepTime: Int) {
        self.sleepTime = sleepTime
        
        super.init(age: age, name: name, live: live)
    }
}

var cat = Cat(age: 3, name: "고양이 1", live: "서울", sleepTime: 10)
cat.age
cat.name
cat.live
cat.sleepTime


var number: Int = 5
