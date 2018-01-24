//
//  ResultDecorator.swift
//  TriviaQuiz
//
//  Created by Mike Yost on 1/20/18.
//  Copyright © 2018 CageFreeSoftware. All rights reserved.
//

import Foundation

class ResultDecorator {
    static func scoreWithAttitude(_ result:QuizResultsModel?) -> String {
        var thumb=""
        if let actualResult = result {
            let ratio = Double(actualResult.correctQuestions) / Double(actualResult.totalQuestions)
            if  ratio <= ScoringConstants.LAME_SCORE_THRESHOLD {
                thumb = " 👎"
            } else {
                thumb = " 👍"
            }
            let judgement = "\(ResultDecorator.score(actualResult)) \(thumb) "
            return judgement
        }
        return ""
    }
    
    static func score(_ result:QuizResultsModel) -> String {
        return "\(result.correctQuestions) out of \(result.totalQuestions)"
    }
}
