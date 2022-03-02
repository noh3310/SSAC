//
//  ValidatorTests.swift
//  SeSACWeek23Tests
//
//  Created by 노건호 on 2022/03/02.
//

import XCTest
@testable import SeSACWeek23

class ValidatorTests: XCTestCase {
    
    var sut: Validator!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = Validator()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testValidator_validID_ReturnTrue() throws {
        // Given
        let user = User(email: "jack@jack.com", password: "123456", check: "123456")
        // When
        let valid = sut.isValidID(id: user.email)
        // Then
        XCTAssertTrue(valid, "이메일 오류입니다.")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
