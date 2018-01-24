//
//  QuizModel.swift
//  TriviaQuiz
//
//  Created by Mike Yost on 1/18/18.
//  Copyright © 2018 CageFreeSoftware. All rights reserved.
//

import Foundation


class QuestionModel {
    var category:String = "?"
    var correct_answer: String = "?"
    var question:String = "?"
    var difficulty: QuestionDifficulty = .easy
    
//  var incorrect_answers:[String] = []  // for multiple choice, but, ya know, YAGNI
    var type:QuizTypeEnum = .boolean
}

enum QuestionDifficulty:String {
    case easy       = "easy"
    case medium     = "medium"
    case hard       = "hard"
    case random     = "random"
    
    var order: Int {
        switch self {
        case .easy:   return 0
        case .medium: return 1
        case .hard:   return 2
        case .random: return 3
        }
    }
    static func levelFor(position:Int) -> QuestionDifficulty {
        switch position {
        case 0: return .easy
        case 1: return .medium
        case 2: return .hard
        case 3: return .random
        default:
            return .random
        }
    }
    static func parseDifficulty(_ input: String) -> QuestionDifficulty {
        if ( input.lowercased() == "easy" ) {
            return QuestionDifficulty.easy
        } else if (input.lowercased() == "medium" ) {
            return QuestionDifficulty.medium
        } else if ( input.lowercased() == "hard" ) {
            return QuestionDifficulty.hard
        } else {
            return QuestionDifficulty.random
        }
    }
}
