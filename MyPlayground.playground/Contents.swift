// foundation프레임워크가 자동으로 상속되어있기 때문에 지워주면 문제가 생길 수 있음
import UIKit
// 두개의 차이점을 따로 문서로 만들어서 공부하는것이 중요할듯
import Foundation

var email: String? = "abc@a.com"
var gender = true   //할당 연산자라고 한다

//email = nil

print("회원 정보: \(email), \(gender)")

// 조건문을 통해 nil을 처리함
// 옵셔널 바인딩, 옵셔널 체이닝이 있음
if email == nil {
    print("이메일을 다시 작성하세요!")
} else {
    print(email!)
}

// 삼항연산자 ? ㅇㅇ : ㄴㄴ
let result = email != nil ? "이메일을 다시 입력하라" : email!
print(result)

// 연락처를 기입하는 텍스트 필드일 경우, 텍스트필드에 작성되는 모든 글자는 문자로 인식이 된다. 숫자를 입력하더라도 String 타입으로 인식이 될 것이다.
var phoneNumber = "01021232123안녕"
type(of: phoneNumber)
// 1. 숫자가 맞는지? 2. 숫자 카운트, 3. 빈 칸 인지

var intValue = Int(phoneNumber)
type(of: intValue)

print(Int8.min)


var foodList: [String] = ["도넛", "아이스크림", "크로플"]
type(of: foodList)
foodList.insert("사탕", at: 1)
foodList.append("초콜릿")
foodList.append(contentsOf: ["a", "b"])
print(foodList)

var numberArray = [Int](1...100)
                    // [Array(repeating: 0, count: 100)]
print(numberArray)

// 아래 코드의 경우 배열의 값을 변환함
numberArray.shuffle()
// 아래 코드의 경우 값을 변환하는게 아니라 리턴하는 코드임
numberArray.shuffled()
// ~ed, ~~ing 메서드의 경우 원본값을 건들지 않는다
print(numberArray)


var sortArray = [3, 4, 5, 10, 8, 1]
sortArray.sort()
print(sortArray)

var sampleString = "SSAC"
sampleString.append(": iOS 앱 개발자 데뷔 과정")
print(sampleString)

var sampleString2 = "SSAC"
sampleString2.appending(": iOS 앱 개발자 데뷔 과정")
print(sampleString2)

// Key가 고유해야 함, 순서가 없음
// : [Int: String]
var dictionary: Dictionary<Int, String> = [ 1: "김철수", 2: "이철수", 3: "김명장" ]
// 출력했을 때마다 순서가 달라지는 것을 알 수 있다.
print(dictionary)

// 여기에서 1번은 인덱스가 아니라 키값을 의미함
dictionary[1]

dictionary[5] = "안겹침"

print(dictionary)

// 신조어검색기(다음주에 만들 내용, 이때 딕셔너리를 사용할 것임)
let wordDictionary = [ "jmt": "존맛탱", "별다줄": "별걸 다 줄인다", "스드메": "스튜디오 드레스 메이크업"]
let userSearchText = "JMT".lowercased()

// 조건문에 비해 간단하게 검색할 수 있기 때문에 사용하는 경우가 많다.
wordDictionary[userSearchText]

let wordArray = [ "jmt", "별다줄", "스드메" ]

let userText = wordArray.randomElement()

if userText == "jmt" {
    print("존맛탱")
}

// 집합(Set)
// 집합의 선언 자체는 배열로 선언해서 선언했을 때 배열로 추론하기 때문에 별도로 Annotation을 해줘야 한다.
let set1: Set<Int> = [1, 3, 4, 5, 6, 7, 7, 7]

// 출력하면 중복된 값을 제거하여 출력해준다.
print(set1)

// 한가지를 더 만들어보겠다
let set2: Set<Int> = [2, 3, 4, 4, 4, 4]

// 교집합이 출력된다.
print(set1.intersection(set2))
