//
//  APIServiceTests.swift
//  SeSACWeek23Tests
//
//  Created by 노건호 on 2022/03/03.
//

import XCTest
@testable import SeSACWeek23

class APIServiceTests: XCTestCase {
    
    var sut: APIService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = APIService()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    // CallRequest > number 1~45
    func testExample1() throws {
        sut.number = 100
        
        sut.callRequest { number in
            XCTAssertLessThanOrEqual(self.sut.number, 45)
            XCTAssertLessThanOrEqual(self.sut.number, 1)
        }
        
    }
    
    // expection, fulfill, wait
    // 비동기: expectation, fullfill, wait
    // 네트워크: 아이폰 네트워크 응답 x, API 서버 점검, API지연
    // => 테스트 더블: 테스트코드와 상호작용을 할 수 있는 가짜 객체 생성(ex. 스턴트맨)
    // => Dummy, Stub, Fake, Spy, Mock => 테스트가 가능한 객체를 만듬
    // => 속도 개선, 테스트 대상 격리, 예측 불가능한 상황X
    func testExample2() throws {
        let promise = expectation(description: "waiting Lotto, Completion Handler Invoked")
        
        sut.number = 100
        
        sut.callRequest { number in
            XCTAssertLessThanOrEqual(self.sut.number, 45)
            XCTAssertGreaterThanOrEqual(self.sut.number, 1)
            promise.fulfill()   // expectation으로 정의한 테스트 조건을 충족한 시점에 호출
        }
        
        wait(for: [promise], timeout: 5) // timeout: 5초가 지나면 실패 간주.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
