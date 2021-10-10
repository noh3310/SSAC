import UIKit

struct Animal {
    var age: Int
    var name: String
    var live: String
}

var cat = Animal(age: 3, name: "고양이 1", live: "서울")
cat.age
cat.name
cat.live

var cat2 = cat

cat.age = 4

cat.age
cat.name
cat.live

cat2.age
cat2.name
cat2.live

