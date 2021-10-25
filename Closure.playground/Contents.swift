import UIKit

/*
 1. 1급 객체
 - 변수나 상수에 함수를 대입할 수 있다. 이유는 함수에도 타입이 있었기 때문이었다.
 -
 */


// 변수나 상수에 함수를 대입할 수 있다.
func checkBankInformation(bank: String) -> Bool {
    let bankArray = ["우리", "KB", "신한"]
    
    return bankArray.contains(bank) ? true : false
}

// 변수나 상수에 함수를 실행하고 나온 반환값을 jack에 대입
let jack = checkBankInformation(bank: "우리") // jack의 타입은 Bool 타입

// 함수로 만들려면 정말 "함수만" 넣어야한다.
// 단지 함수만 대입했기 때문에 실행되지는 않는다.
// 함수를 호출해야 실행된다.
let jackAccount = checkBankInformation // jackAccount의 타입은 함수 타입
// 함수를 호출해야 실행된다.
jackAccount("신한")
// 위의 내용이 1급객체에 대한 내용이다(함수를 변수나 상수에 담을 수 있다)

// jackAccount를 클릭하면 (String) -> Bool가 뜨는것을 확인할 수 있다.
// 이것은 Function Type이라고 한다.

// 튜플은 아래와같이 되어있는것을 확인할 수 있다.
// 튜플의 타입이 항상 유동적인것처럼 Function Type을 매개변수와 반환값을 가지고 알 수 있는데요
let tupleExample = (1, true, "dkd", 3.3)
tupleExample.1

// hello 함수를 하나 만들겠다.
// Function Type 1. (String) -> String
func hello(nickname: String) -> String {
    return "저는 \(nickname)입니다."
}

// 위의 함수를 이름만 바꿔서 넣음
func hello(userName: String) -> String {
    return "저는 \(userName)입니다."
}

// Function Type 2. (String, Int) -> String
func hello(nickname: String, userAge: Int) -> String {
    return "저는 \(nickname), \(userAge)입니다."
}

// Function Type 3. () -> Void, () -> () 두가지로 표현이 가능하다(매개변수가 없다는것을 ()로 나타낼 수 있음
// typealias Void = () 로 선언되있다.
// 요새는 Void 말고 ()를 많이 사용한다.
func hello() -> Void {
    print("안녕하세요 반갑습니다.")
}

// 함수를 구분하기 힘들 때 타입 어노테이션을 통해 함수를 구별할 수 있다.
let a = hello(nickname:)
let b: (String, Int) -> String = hello(nickname: userAge:)
let c: () -> () = hello

// b 상수를 hello함수처럼 쓸 수 있다!
b("ssss", 1)
b("hello", 28)


// 2. 함수의 반환 타입으로 함수를 사용할 수 있다. 구조체나 클래스 등 반환값으로 사용할 수 있음
// 함수 타입은 () -> String
func currentAccount() -> String {
    return "계좌 있음"
}

// 함수 타입은 () -> String
func noCurrentAccount() -> String {
    return "계좌 없음"
}

// Bool을 괄호로 감싸면서 반환 타입을 함수로 선언해줬다.
// 가장 왼쪽에 위치한 ->를 기준으로 오른쪽에 놓인 모든 타입은 반환값을 의미한다.
func checkBank(bank: String) -> () -> String {
    let bankArray = ["우리", "KB", "신한"]
    
    return bankArray.contains(bank) ? currentAccount : noCurrentAccount
}

let minsu = checkBank(bank: "농혐")
// 다음과 같이 불러줘야지 계좌 없음이 반환되는 것을 알 수 있다.
minsu()

// 2-1. Calculate (Int, Int) -> Int
func plus(a: Int, b: Int) -> Int {
    return a + b
}

func minus(a: Int, b: Int) -> Int {
    return a - b
}

func multiply(a: Int, b: Int) -> Int {
    return a * b
}

func divide(a: Int, b: Int) -> Int {
    return a / b
}

func calculate(operand: String) -> (Int, Int) -> Int {
    switch operand {
    case "+": return plus
    case "-": return minus
    case "*": return multiply
    case "/": return divide
    default: return plus
    }
}

// 아래처럼 매개변수를 뒤에 한번에 합쳐서 사용할 수도 있다.
// 하지만 가독성을 위해서 가급적 단계를 나눠서 작성하는 편이다.
let result = calculate(operand: "-")//(4, 3)
result(5, 3)


// 3. 함수의 매개변수에도 함수를 사용할 수 있다(콜백함수로 자주 사용됨)
// 콜백함수: 특정 구문의 실행이 끝나면 시스템이 호출하도록 처리된 함수
// 함수 타입: () -> ()
func oddNumher() {
    print("홀수")
}

func evenNumber() {
    print("짝수")
}

// 리턴해줄때 ()를 추가해준다. 리턴해줄때 변수인지, 함수인지 정확하게 모르기 때문
func resultNumber(base: Int, odd: () -> (), even: () -> ()) {
    return base.isMultiple(of: 2) ? even() : odd()
}

resultNumber(base: 9, odd: oddNumher, even: evenNumber)

// 타입: () -> ()

func plusNumber() {
    print("더하기")
}

func minusNumber() {
    print("빼기")
}

// 위의 두 함수는 oddnumber, evenNumber함수와 타입이 같기 때문에 resultNumber메서드의 매개변수에 같은 타입의 다른 함수들이 들어가도 타입만 잘 맞으면 된다는 문제가 있다.
// 실질적인 연산은 인자값으로 받는 함수에 달려있어서, 중개 역할만 담당한다고 하여 브로커라고 부른다고 한다.
resultNumber(base: 1, odd: plusNumber, even: minusNumber)

// 아래 형태를 익명 함수라고 하고, 클로저에 대해서 배울 것이다.
// 마지막의 매개변수만 남게 되서 가독성이 떨어질 위험은 있으나 생각보다 많은 함수에서 쓰고 있으므로 알아둬야 한다.
resultNumber(base: 9) {
    print("Success")
} even: {
    print("FAILED")
}
// 클로저는 굉장히 많이 생략되어 있다. 클로저에 숨어있는 요소가 많기 때문에 알아보도록 하겠다.
// 클로저의 유래에 대해 봅시다... 닫혀있다. 닫혀있는 함수라고 생각하면 된다. 커다란 함수의 생명주기에 영향을 받게 되어있다.

// 바깥에 있는 함수를 외부함수, 안에 있는 함수를 내부함수라고 한다. 내부함수는 클로저에 연관되어 있다.
func drawingGame(item: Int) -> String {
    
    // 함수안에 함수를 선언
    func luckyNumber(number: Int) -> String {
        return "\(item * number * Int.random(in: 1...5)) 입니다."
    }
    
    let result = luckyNumber(number: item * 2)
    
    return result
}

// 내부함수의 경우 외부함수를 생성했을 때 삭제된다.

drawingGame(item: 10)

func drawingGame2(item: Int) -> (Int) -> String {
    
    // 함수안에 함수를 선언
    func luckyNumber(number: Int) -> String {
        return "\(item * number * Int.random(in: 1...5)) 입니다."
    }
    
    return luckyNumber
}

let luckyNumber2 = drawingGame2(item: 10) // 외부함수는 생명 주기가 끝남
luckyNumber2(2) // 외부함수가 생명주기가 끝나더라도 내부 함수는 계속 사용 할 수 있다는 문제가 생기게 된다.

// 은닉성이 있는 내부 함수를 외부 함수의 실행 결과로 반환하면서 내부 함수를 외부에서도 접근 가능하게 되었음. 이제 얼마든지 호출할 수 있다. 이건 생명 주기에에도 영향을 미치므로 외부 함수가 종료되더라도 내부 함수는 살아있게 된다.
// 내부 함수에서 외부 함수의 변수를 사용할 수 있는것은 내부 함수에서 "클로저 캡처"라는것을 사용하기 때문에 가능하다.

/*
 드디어 클로저를 봅시다.
 같은 정의를 갖는 함수가 서로 다른 환경을 저장하는 결과가 생기게 된다.
 클로저에 의해 내부 함수 주변의 지역 변수나 상수도 함께 저장된다.
 -> 값이 캠처되었다고 표현한다.
 주변 환경에 포함된 변수나 상수의 타입이 기본 자료형이나 구조체 자료형일 때 발생한다. 클로저 캡처 기본 기능이다.
 
 !!! 스위프트는 특히 이름이 없는 함수로 클로저를 사용하고 있고, 주변환경(내부 함수 주변의 변수나 상수)로부터 값을 캡쳐할 수 있는 "경량 문법"으로 많이 사용하고 있다.
 */

// 이제 클로저를 보겠다.
// () -> ()
func studyiOS() {
    print("iOS 개발자를 위해 열공중")
}

// 이게 클로저 구문이다.
let studyiOSHearder = {
    print("iOS 개발자를 위해 열공중")
}

// 함수의 내용을 적어줌
// in 앞의 내용을 클로저 헤더라고 부르고, in 뒤에는 body라고 부른다.
let studyiOSHearder2 = { () -> () in
    print("iOS 개발자를 위해 열공중")
}

studyiOSHearder2()

//let studyiOSHearder3: () = { () -> () in
//    print("iOS 개발자를 위해 열공중")
//}()
//
//studyiOSHearder3


func getStudyWithMe(study: () -> ()) {
    study()
}

// 인라인 클로저
getStudyWithMe (study: { () -> () in
    print("iOS 개발자를 위해 열공중")
})

getStudyWithMe(study: studyiOSHearder2)

// 트레일링 클로저
getStudyWithMe() { () -> () in
    print("iOS 개발자를 위해 열공중")
}


// 클로저는 다양하게 쓸 수 있는데 문법적인 부분이 다름

func todayNumber(result: (Int) -> String) {
    result(Int.random(in: 1...100))
}

// 클로저를 전체다 적어놓은것
todayNumber(result: { (number: Int) -> String in
    return "행운의 숫자는 \(number) 입니다."
})

// 반환값과 타입을 지울 수 있다.
todayNumber(result: { (number) in
    return "행운의 숫자는 \(number) 입니다."
})

// 매개변수도 생략할 수 있다.
// $에 대한 정확한 명칭이 있는데 찾아보기
// 매개변수가 생략되면 $0, $1 .... 처럼 할당된 내부 상수를 사용할 수 있다.
todayNumber(result: {
    return "행운의 숫자는 \($0) 입니다."
})

// 실행될 코드가 한줄이라면 return도 생략할 수 있다.
todayNumber(result: {
    "행운의 숫자는 \($0) 입니다."
})

// 최종적으로 이렇게 생략할 수 있다.
todayNumber() { "\($0)" }

// in 앞에 원하는 매개변수를 적어주면 됨
todayNumber { value in
    print("하하하")
    return "\(value)입니다."
}


// @autoclosure, @escaping이 사용된다. 이것은 한번 찾아보시길

/*
 1급객체의 특성인 변수와 함수를 담을 수 있다, 인자값을 담을 수 있다, 이것을 적극적으로 활용하면서 함수형 프로그래밍을 사용할 수 있다.
 */
