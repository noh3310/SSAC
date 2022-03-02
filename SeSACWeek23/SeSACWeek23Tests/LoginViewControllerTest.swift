//
//  LoginViewControllerTest.swift
//  SeSACWeek23Tests
//
//  Created by 노건호 on 2022/03/02.
//

import XCTest
@testable import SeSACWeek23

class LoginViewControllerTest: XCTestCase {
    
    var sut: LoginViewController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController)
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    // BDD(Bthavior Driven Development, 행위주도 개발)
    // TDD
//    func testLoginViewController_ValidID_ReturnTrue() throws {
//        // Given, Arrange
//        sut.idTextField.text = "jack@jack.com"
//        // When, Act
//        let valid = sut.isValidID()
//        // Then, Assert
//        XCTAssertTrue(valid, "@가 없거나 6글자 미만이라서 안될 수 있음")
//    }
//
//    func testLoginViewController_inValidPassword_ReturnFalse() throws {
//        sut.passwordTextField.text = "1234"
//        let valid = sut.isValidPassword()
//
//        XCTAssertTrue(valid, "비밀번호가 6자리이상이 아닙니다.")
//    }
//
//    func testLoginViewController_idTextField_ReturnNil() throws {
//        sut.idTextField = nil
//
//        let value = sut.idTextField
//
//        XCTAssertNil(value)
//    }
//
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
