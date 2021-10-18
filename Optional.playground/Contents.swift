import UIKit

class Student {
    var studentID: String?
    var name: String?

    init(studentID: String, name: String) {
        self.studentID = studentID
        self.name = name
    }
}

var student: Student? = Student(studentID: "010101010", name: "홍길동")

if let studentId = student?.studentID {
    print(studentId)
}
