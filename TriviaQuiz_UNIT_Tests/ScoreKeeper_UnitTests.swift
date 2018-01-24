//
//  ScoreKeeper_UnitTests.swift
//  TriviaQuiz_UNIT_Tests
//
//  Created by Mike Yost on 1/24/18.
//  Copyright © 2018 CageFreeSoftware. All rights reserved.
//

import XCTest

class ScoreKeeper_UnitTests: XCTestCase {

    func test_thatCurrentQuestionIndexIsSettableAndGettable() {
        let scoreKeep = ScoreKeeper()
        scoreKeep.currentQuestionIndex = 5
        XCTAssert(scoreKeep.currentQuestionIndex == 5,"currentQuestionIndex not settable/gettable")
    }

    func test_thatQuestionListIsSettableAndGettable_trivial() {
        let scoreKeep = ScoreKeeper()
        scoreKeep.questionList = []
        XCTAssert(scoreKeep.questionList.count == 0,"QuestionList not settable/gettable")
    }
    
    func generateQuestionlist(howMany:Int) -> [QuestionModel] {
        var temp:[QuestionModel]=[]
        for foo in 0..<howMany {
            let question = "\(foo)"
            let model = QuestionModel()
            model.question = question
            if foo % 2 == 0 {                   // make even answers True
                model.correct_answer = "True"
            } else {
                model.correct_answer = "False"
            }
            temp.append(model)
        }
        return temp
    }
    func test_thatQuestionListIsSettableAndGettable_nonTrivial() {
        let scoreKeep = ScoreKeeper()
        scoreKeep.questionList = generateQuestionlist(howMany: 5)
        XCTAssert(scoreKeep.questionList[0].question == "0", "scoreKeep question wrong")
        XCTAssert(scoreKeep.questionList[4].question == "4", "scoreKeep question wrong")
    }
    
    func test_thatResultModelIsGettable() {
        let scoreKeep = ScoreKeeper()
        let resultModel = scoreKeep.resultModel
        XCTAssert(resultModel==nil,"cannot access result model")
    }
    
    func test_TrueAndFalseHandlersAreAccessible() {
        let scoreKeep = ScoreKeeper()
        scoreKeep.questionList = generateQuestionlist(howMany: 2)
        scoreKeep.handleTrue()
        scoreKeep.handleFalse()
    }
    
    func test_tallyScoreResults_allCorrect() {
        let scoreKeep = ScoreKeeper()
        scoreKeep.questionList = generateQuestionlist(howMany: 4)
        scoreKeep.handleTrue()
        scoreKeep.handleFalse()
        scoreKeep.handleTrue()      // Note, even answers are tru
        scoreKeep.handleFalse()
        
        let results = scoreKeep.resultModel
        XCTAssert(results != nil,"Unexpected nil results")
        XCTAssert(results?.totalQuestions == 4,"totalQuestions should be 4")
        XCTAssert(results?.correctQuestions == 4, "correctQuestions should be 4")
    }
    
    func test_tallyScoreResults_correctNotSoMuch() {
        let scoreKeep = ScoreKeeper()
        scoreKeep.questionList = generateQuestionlist(howMany: 4)
        scoreKeep.handleFalse() // Note: these will all be incorrect.
        scoreKeep.handleTrue()
        scoreKeep.handleFalse()
        scoreKeep.handleTrue()
        
        let results = scoreKeep.resultModel
        XCTAssert(results != nil,"Unexpected nil results")
        XCTAssert(results?.totalQuestions == 4,"totalQuestions should be 4")
        XCTAssert(results?.correctQuestions == 0, "correctQuestions should be 0")
    }
}
