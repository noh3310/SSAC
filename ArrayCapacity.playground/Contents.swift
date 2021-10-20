import UIKit

var sample = Array(repeating: "가", count: 100)

sample.count
sample.capacity // 능력이라는것이 새로 생김

sample.append(contentsOf: Array(repeating: "나", count: 100))

sample.count
sample.capacity


var sample2: [Int] = []

for i in 1...200 {
    sample2.append(i)
    sample2.count
    sample2.capacity
}


var str = "Hello World - hello"

var t = str.replacingOccurrences(of: " ", with: "_")

t
