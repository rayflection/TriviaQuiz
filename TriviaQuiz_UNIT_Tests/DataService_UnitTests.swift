//
//  DataService_UnitTests.swift
//  TriviaQuiz_UNIT_Tests
//
//  Created by Mike Yost on 1/23/18.
//  Copyright © 2018 CageFreeSoftware. All rights reserved.
//

import XCTest

// MARK: Supporting classes
class QuizConfig_BadUrlFormat: QuizConfig {
    override func getUrlString() -> String {  return "I_AM_A_REALLY_BAD_URL"  }
}
class QuizConfig_BadUrlParameters: QuizConfig {
    override func getUrlString() -> String { return "https://opentdb.com/api.php?amount=ABC"}
}
class QuizConfig_BadUrl_notFound: QuizConfig {
    override func getUrlString() -> String { return "https://opentdb123MichaelYost456.comARomDom/"}
}

// MARK: tests
class DataService_UnitTests: XCTestCase {
    //
    // Wait for a promise, test is ending before closure gets called.
    //
    func testGoodUrl() {
        let quizConfig = QuizConfig()
        let service = QuizDataService()
        let expect = expectation(description: "Good Url")
        service.fetchData(with: quizConfig) { (data, message) -> Void in
            XCTAssert(data != nil,"Got nil data back from Data Service.")
            XCTAssert(message == nil, "Got non-nil error message:\(String(describing: message))")
            let questionModelList = QuestionParser.parseList(data!)
            XCTAssert(questionModelList.count == 10, "Should be 10 questions")
            let model = questionModelList[0]
            XCTAssert(model.type == .boolean, "type should be 'boolean'")
            expect.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testBadUrlSyntax() {
        let expect = expectation(description: "Bad Url")
        
        let quizConfig = QuizConfig_BadUrlFormat()
        print("url: \(quizConfig.getUrlString())")
        QuizDataService().fetchData(with: quizConfig) { (data, message) -> Void in
            XCTAssert(data == nil,"Got non-nil data back from Bad Url.")
            XCTAssert(message != nil, "Got nil error message from a failure")
            expect.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    func testBadUrlParameter() {
        let expect = expectation(description: "Worse Url")
        
        let quizConfig = QuizConfig_BadUrlParameters()
        print("url: \(quizConfig.getUrlString())")
        QuizDataService().fetchData(with: quizConfig) { (data, message) -> Void in
            XCTAssert(data != nil,"Got nil data back, should be there, but empty.")
            XCTAssert(data?.count == 0, "Expected empty array, got \(String(describing: data?.count))")
            XCTAssert(message == nil, "Unexpected error message")
            expect.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testBadUrl_notFound() {
        let expect = expectation(description: "Worst Url")
        
        let quizConfig = QuizConfig_BadUrl_notFound()
        print("url: \(quizConfig.getUrlString())")
        QuizDataService().fetchData(with: quizConfig) { (data, message) -> Void in
            XCTAssert(data == nil,"Got nil data back, should be there, but empty.")
            XCTAssert(message != nil, "Missing error message")
            expect.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
}
