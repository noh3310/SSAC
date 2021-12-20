import UIKit

// Codable이라는 프로토콜에 대해 학습해보려고 한다.
let json = """
{
"quote_content": "Your body is made to move so move it.",
"author": "Toni Sorenson"
}
"""

// json["author"].stringValue

// class, struct, enum
// 제일 선호하는것은 struct이다.
struct Quote: Decodable {
    var quote: String?
    var author: String?
    var quoteContent: String?
    var authorName: String?
    
    // 이것은 명칭이 있기때문에 정확하게 처리해줘야함
    // 커스텀 키로 매핑해줄 수 있음
    enum CodingKeys: String, CodingKey { // 항상 내부적으로 생성이 되어 있음.
        case quote = "quote_content"
        case author, quoteContent, authorName // 만약 상관이 없다면 생략해서 사용해도 됨
    }
}

// String -> Data
guard let result = json.data(using: .utf8) else { fatalError("failed") }
print(result)


let decoder = JSONDecoder()
//decoder.keyDecodingStrategy = .convertFromSnakeCase

// Data -> Quote
do {
    let value = try decoder.decode(Quote.self, from: result)
    print(value)
} catch {
    print(error)
}

/*
 Optional로 선언을 하면
 데이터가 제대로 들어가지 않고, nil값으로 떨어지는것을 확인할 수 있다.
 Custom Key - CodingKey
 
 */




// Meta Type
// String의 타입은 String.Type. 메타 타입은 클래스 구조체 열거형 등의 타입 자체를 가리킴
let name: String = "JACK"
type(of: name)

// quote의 타입은? -> 구조체 타입
// quote: 인스턴스에 대한 타입
// Quote구조체 자체의 타입은 뭐야? -> Quote.Type
let quote = Quote(quote: "명언", author: "Jack")
type(of: quote)

struct User {
    var name = "고래밥"
    static let identifier = 1234    // 타입 프로퍼티
}

let user = User()
user.name
type(of: user)

// 타입메서드나 타입프로퍼티에서 "타입"이라는 이름이 붙은 이유가 이것 때문이다. someClass.self는 SomeClass와 같다.
// 이를 이용하면 컴파일떄가 아니라 런타임때에 값을 알 수 있다.
let age: Any = 15
// Any타입이지만 실제로 런타임을 돌려봤을 때 Int타입으로 설정이 되어있는것을 확인할 수 있다.
type(of: age)
