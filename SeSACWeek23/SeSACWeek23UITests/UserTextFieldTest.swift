//
//  UserTextFieldTest.swift
//  SeSACWeek23UITests
//
//  Created by 노건호 on 2022/02/28.
//

import XCTest

class UserTextFieldTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        // 실패하고 플로우를 계속 실행할것인지(초기화는 false)
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.textFields["firstTextField"].tap()
        app.textFields["firstTextField"].typeText("안녕하세요")

        app.textFields["secondTextField"].tap()
        app.textFields["secondTextField"].typeText("123")

        app.textFields["thirdTextField"].tap()
        app.textFields["thirdTextField"].typeText("Good Bye")
        
        app.buttons["firstButton"].tap()
        
        XCTAssertEqual(app.staticTexts.element(matching: .any, identifier: "resultLabel").label, "안녕하세요", "먼가 잘못됬다 어떤걸 수정해야한다")
    }
}
