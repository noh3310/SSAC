import Foundation

class Person {
    let birthday: Date
    var age: Int {
        willSet(newAge) {
            print(self.age, "에서 ", newAge, "로 변하기 직전")
        }
        didSet(oldAge) {
            print(oldAge, "에서 ", self.age, "로 변한 직후")
        }
    }
    var koreanAge: Int {
        get {
            self.age - 1
        }
        set {
            self.age = newValue + 1
        }
    }
    
    init(birthday: Date, age: Int) {
        self.birthday = birthday
        self.age = age
    }
}

// onePerson 인스턴스 생성
let onePerson = Person(birthday: Date(), age: 2)

// 만 나이 출력(연산 프로퍼티)
onePerson.koreanAge

onePerson

// 연산 프로퍼티 설정(set 실행됨)
onePerson.koreanAge = 3

onePerson

