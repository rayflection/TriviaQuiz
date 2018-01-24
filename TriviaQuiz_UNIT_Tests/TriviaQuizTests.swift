//
//  TriviaQuizTests.swift
//  TriviaQuizTests
//
//  Created by Mike Yost on 1/18/18.
//  Copyright © 2018 CageFreeSoftware. All rights reserved.
//

import XCTest
@testable import TriviaQuiz

class QuizConfig_UnitTests: XCTestCase {
    
    func test_QuizConfigRequest_ImplicitInit_DefaultValues() {
        let request = QuizConfigRequest()
        XCTAssert(request.count == 10, "Default count should be 10")
        XCTAssert(request.type == QuizTypeEnum.boolean, "Default type should be .boolean")
        XCTAssert(request.difficulty == QuestionDifficulty.random, "Default difficulty should be .random")
    }
    
    func test_QuizConfig_ImplicitInit_RequestAndDefaultValues() {
        let quizConfig = QuizConfig()
        
        XCTAssert(quizConfig.request.count == 10, "QuizConfig.request.count should init to 10")
        XCTAssert(quizConfig.request.type == QuizTypeEnum.boolean, "QuizConfig.request.type should init to .boolean")
        XCTAssert(quizConfig.request.difficulty == QuestionDifficulty.random, "QuizConfig.request.difficulty should init to .random")
        let url = quizConfig.getUrlString()
        XCTAssert(url.hasPrefix("https://opentdb.com/api.php?"), "Url mangled")
        XCTAssert(url.range(of:"amount=10") != nil,"Url amount parameter missing or incorrect")
        XCTAssert(url.range(of:"type=boolean") != nil, "Url type parameter missing or incorrect")
        XCTAssert(url.range(of:"difficulty=") == nil, "Url should NOT have a difficulty param for .random")
    }
    

    func test_QuizConfig_ExplicitInit_RequestValues() {
        var request = QuizConfigRequest()
        request.count = 15
        request.type  = QuizTypeEnum.boolean
        request.difficulty = QuestionDifficulty.hard
        
        XCTAssert(request.count == 15, "Request count should be set to 15")
        XCTAssert(request.type == QuizTypeEnum.boolean, "Request type should be .boolean")
        XCTAssert(request.difficulty == QuestionDifficulty.hard, "Request difficulty should be .hard")
        
        let quizConfig = QuizConfig(request:request)
        XCTAssert(quizConfig.request.count == 15, "QuizConfig.request.count should be set to 15")
        XCTAssert(quizConfig.request.type == QuizTypeEnum.boolean, "QuizConfig.request.type should still be .boolean")
        XCTAssert(quizConfig.request.difficulty == QuestionDifficulty.hard, "QuizConfig.request.difficulty should be set to .hard")
        
        let url = quizConfig.getUrlString()
        XCTAssert(url.hasPrefix("https://opentdb.com/api.php?"), "Url mangled")
        XCTAssert(url.range(of:"amount=15") != nil,"Url amount parameter missing or incorrect")
        XCTAssert(url.range(of:"type=boolean") != nil, "Url type parameter missing or incorrect")
        XCTAssert(url.range(of:"difficulty=hard") != nil, "Url should have a difficulty param for .hard")
    }
    
    func test_QuizConfig_ExplicitInit_CountMin() {
        var request = QuizConfigRequest()
        request.count = QuizConfig.minQuestionCount - 1

        let config = QuizConfig(request:request)
        XCTAssert(config.request.count == QuizConfig.minQuestionCount,"Count less than minimum")
    }
    func test_QuizConfig_ExplicitInit_CountMax() {
        var request = QuizConfigRequest()
        request.count = QuizConfig.maxQuestionCount + 1
        
        let config = QuizConfig(request:request)
        XCTAssert(config.request.count == QuizConfig.maxQuestionCount,"Count greater than maximum")
    }
}
