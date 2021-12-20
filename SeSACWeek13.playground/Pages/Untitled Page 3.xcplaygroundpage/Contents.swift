//: [Previous](@previous)

import Foundation

// json으로 만들 수 있도록 프로토콜을 채택
struct User: Encodable {
    var name: String
    var signUpDate: Date
    var age: Int
}

let users: [User] = [
    User(name: "jack", signUpDate: Date(), age: 33),
    User(name: "Elas", signUpDate: Date(timeInterval: -86400, since: Date()), age: 32),
    User(name: "Ellie", signUpDate: Date(timeIntervalSinceNow: 86400), age: 31)
]

dump(users)

let encode = JSONEncoder()
// 이렇게하면 예쁘게 Json으로 나옴
encode.outputFormatting = .prettyPrinted
encode.outputFormatting = .sortedKeys
//encode.dateEncodingStrategy = .iso8601 // (rfc 3339)

let format = DateFormatter()
format.locale = Locale(identifier: "ko-KR")
format.dateFormat = "yyyy년 MM월 dd일 EEEE"
encode.dateEncodingStrategy = .formatted(format)

do {
    let jsonData = try encode.encode(users)
    
//    dump(jsonData)
    // json을 utf8방식으로 변환하겠다.
    guard let jsonString = String(data: jsonData, encoding: .utf8) else { fatalError("오류") }
    print(jsonString)
} catch {
    print(error)
}

//: [Next](@next)
