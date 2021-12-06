//: [Previous](@previous)

import Foundation

// 영진원 API: 20211021, "", "문자", "20211133"

func checkDateFormat(text: String) -> Bool {
    let format = DateFormatter()
    format.dateFormat = "yyyyMMdd"
    
    return format.date(from: text) == nil ? false : true
}

func validateUserInput(text: String) -> Bool {
    // 사용자가 입력한 값이 빈 값인 경우
    guard !(text.isEmpty) else {
        print("빈 값입니다.")
        return false
    }
    
    // 사용자가 입력한 값이 숫자인지
    guard Int(text) != nil else {
        print("숫자 아님")
        return false
    }
    
    // 사용자가 입력한 값이 날짜 형태로 변환이 되는 숫자인지 아닌지
    guard checkDateFormat(text: text) else {
        print("날짜 형태가 아닙니다")
        return false
    }
    
    return true
}


if validateUserInput(text: "20220101") {
    print("검색 가능")
} else {
    print("검색 불가능")
}

// ------------------------------------------------
// 오류처리 패턴: do try catch / Erorr 프로토콜 준수
// 컴파일러가 오류 타입을 인정할 수 있게 된다.
// 프로젝트에서 빌드 버튼을 클릭했을때 오류를 제대로 준수했는지 사용가능
enum ValidationError: Int, Error {
    case emptyString = 401
    case invalidInt = 402
    case invalidDate = 403
}

func validateUserInputError(text: String) throws -> Bool {
    // 사용자가 입력한 값이 빈 값인 경우
    guard !(text.isEmpty) else {
        throw ValidationError.emptyString
    }
    
    // 사용자가 입력한 값이 숫자인지
    guard Int(text) != nil else {
        throw ValidationError.invalidInt
    }
    
    // 사용자가 입력한 값이 날짜 형태로 변환이 되는 숫자인지 아닌지
    guard checkDateFormat(text: text) else {
        throw ValidationError.invalidDate
    }
    
    return true
}

do {
    let result = try validateUserInput(text: "20211111")
    print("성공")
    
} catch ValidationError.emptyString {
    print("문자열이 없습니다.")
    print(ValidationError.emptyString.rawValue)
} catch ValidationError.invalidInt {
    print("숫자가 아닙니다.")
    print(ValidationError.invalidInt.rawValue)
} catch ValidationError.invalidDate {
    print("날짜가 아닙니다.")
    print(ValidationError.invalidDate.rawValue)
}

// 코드가 지금은 간소하지만 나중에 커진다면 에러 핸들링이 쉽게 사용할 수 있게 느낄 수 있을 것이다.

do {
    let result = try validateUserInput(text: "20211111")
    print("성공")
} catch {
    switch error {
    case ValidationError.emptyString: print("날짜 값이 아닙니다.")
    case ValidationError.invalidInt: print("숫자가 비어있습니다.")
    case ValidationError.invalidDate: print("날짜가 아닙니다.")
    default:
        print("default")
    }
}

//: [Next](@next)
