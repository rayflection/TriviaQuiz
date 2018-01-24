//
//  QuizResults.swift
//  TriviaQuiz
//
//  Created by Mike Yost on 1/19/18.
//  Copyright © 2018 CageFreeSoftware. All rights reserved.
//

import Foundation


struct ResultItem {
    var isCorrect:Bool=false
    var correctAnswer=""
    var question=""
    var difficulty:QuestionDifficulty = .easy
}
class QuizResultsModel {
    
    var correctQuestions=0
    var totalQuestions=0
    var results:[ResultItem]=[]

}
