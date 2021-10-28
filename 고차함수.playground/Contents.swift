import Foundation

//아래 3가지를 말한다.
//- map
//- filter
//- reduce

//고차함수는 1급객체의 특성을 가진다. 매개변수와 반환값에 함수를 사용할 수 있다.
// 바로 코드로 들어가보겠다.

// 학생 4.0 이상
let student = [2.2, 3.3, 4.4, 4.5]

var resultStudent: [Double] = []

for i in student {
    
    if i >= 4.0 {
        resultStudent.append(i)
    }
}

print(resultStudent)

// filter 사용(클로저를 파라미터에 담고있다고 생각하면 된다)
// 장점은 새롭게 결과를 담기위한 배열을 만들지 않아도 된다.
// 속도 측면에서도 유용하게 사용할 수 있을 것이다.
let resultFilter = student.filter { score in score >= 4.0 }
print(resultFilter)

// 매개변수를 $0, $1처럼 사용할 수 있을 것이다.
let resultFilter2 = student.filter { $0 >= 4.0 }
print(resultFilter2)


// 원하는 영화를 가지고 오고싶을때
// Dictionary 사용
let movieList = [
    "괴물":"박찬욱",
    "기생충":"봉준호",
    "인터스텔라":"크리스토퍼 놀란",
    "인셉션":"크리스토퍼 놀란",
    "옥자":"봉준호"
]

// dictionary는 순서를 가지지 않는데, 순서를 가질 수 있도록 해줌
let sortMovie = movieList.sorted(by: { $0.key < $1.key })
print(sortMovie)

var movieResult: [String] = []
for (movieName, director) in movieList {
    if director == "봉준호" {
        movieResult.append(movieName)
    }
}

let movieFilter = movieList.filter { $0.value == "봉준호" }
print(movieFilter)


// ["옥자": "봉준호", "기생충": "봉준호"]를 영화만 출력하고 싶을 때, filter랑 map 두개를 써야함
let movieFilter2 = movieList.filter { $0.value == "봉준호" }.map { $0.key }
print(movieFilter2)

// map을 활용해보겠다.
let number = [1, 2, 3, 4, 5, 6, 7, 8, 9]
var resultNumber: [Int] = []

for n in number {
    resultNumber.append(n * 2)
}

let mapNumber = number.map { $0 * 2 }
print(mapNumber)



// reduce
// 요소들을 합치고 싶을 떄 유용하게 사용할 수 있음
let exam = [40, 60, 70, 10, 20, 30]

// 다 더해서 전체값을 리턴하고 싶다면
var totalCount = 0

for i in exam {
    totalCount += i
}

let reduceCount = exam.reduce(0) { $0 + $1 }
print(reduceCount)

