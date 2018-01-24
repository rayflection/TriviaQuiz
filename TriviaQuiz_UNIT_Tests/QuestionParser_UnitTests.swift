//
//  QuestionParser_UnitTests.swift
//  TriviaQuiz_UNIT_Tests
//
//  Created by Mike Yost on 1/23/18.
//  Copyright © 2018 CageFreeSoftware. All rights reserved.
//

import XCTest

class QuestionParser_UnitTests: XCTestCase {

    
    func dataVendor() -> [NSDictionary] {
        let testData: [Dictionary<String, String>]  =
        [
            [
                "difficulty"        : "easy",
                "correct_answer"    : "True",
                "incorrect_answers" : "False",
                "type"              : "boolean",
                "category"          : "Entertainment",
                "question"          : "Clefairy was intended to be in the pilot episode of the cartoon."
            ],
            [
                "difficulty"        : "medium",
                "correct_answer"    : "True",
                "incorrect_answers" : "False",
                "type"              : "boolean",
                "category"          : "Geography",
                "question"          : "CA group of islands is called an &#039;archipelago&#039."
            ],
            [
                "difficulty"        : "hard",
                "correct_answer"    : "True",
                "incorrect_answers" : "False",
                "type"              : "boolean",
                "category"          : "Cooking",
                "question"          : "There are 4 cups in a quart."
            ],
            [
                "difficulty"        : "easy",
                "correct_answer"    : "False",
                "incorrect_answers" : "True",
                "type"              : "boolean",
                "category"          : "Geography",
                "question"          : "There is a city called Rome in every continent on Earth."
            ]
        ]

        return testData as [NSDictionary]
    }
 
    func test_parser_good_data() {
        let testData = dataVendor()
        
        let questions = QuestionParser.parseList(testData)
        XCTAssert(questions.count == 4, "Should be 4 questions")
        let model:QuestionModel = questions[0]
        XCTAssert(model.category == "Entertainment","Category should be 'Entertainment'")
        XCTAssert(model.type == .boolean, "Type should be .boolean")
        XCTAssert(model.difficulty == QuestionDifficulty.easy, "Difficulty should be .easy")
        
    }

}
