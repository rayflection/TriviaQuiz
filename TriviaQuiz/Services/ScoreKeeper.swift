//
//  ScoreKeeper.swift
//  TriviaQuiz
//
//  Created by Mike Yost on 1/19/18.
//  Copyright © 2018 CageFreeSoftware. All rights reserved.
//

import Foundation

class ScoreKeeper {
    
    var currentQuestionIndex = 0;
    var questionList:[QuestionModel]=[];
    public private(set) var resultModel:QuizResultsModel?
    private var responses:[String]=[];

    func handleTrue() {
        responses.append("true")
        increment()
    }
    
    func handleFalse() {
        responses.append("false")
        increment()
    }
    
    // MARK: - Internal
    private func increment() {
        currentQuestionIndex += 1
        if currentQuestionIndex >= questionList.count {
            tallyScore()
            resetForNextRound()
            notifyQuizIsDone()
        } else {
            notifyMoveToNextQuestion()
        }
    }
    
    private func tallyScore() {
        assert(responses.count==questionList.count,"# questions != # answers")
        assert(responses.count>0,"no questions or no answers")
        resultModel = QuizResultsModel()
        var numberCorrect = 0
        for (index, response) in responses.enumerated() {

            let question = questionList[index]
            
            var resultItem = ResultItem()
            resultItem.question = question.question
            resultItem.correctAnswer = question.correct_answer
            resultItem.difficulty = question.difficulty
            
            if response.lowercased() == question.correct_answer.lowercased() {
                numberCorrect += 1
                resultItem.isCorrect = true
            } else {
                resultItem.isCorrect = false
            }
            resultModel?.results.append(resultItem)
        }
        resultModel?.correctQuestions = numberCorrect
        resultModel?.totalQuestions = responses.count
    }
    private func resetForNextRound() {
        responses=[]
        currentQuestionIndex=0
    }
    private func notifyQuizIsDone() {
        NotificationCenter.default.post(
            name: NSNotification.Name(rawValue: NotificationKey.quizDone),
            object: self, userInfo: nil )
    }
    private func notifyMoveToNextQuestion() {
        NotificationCenter.default.post(
            name: NSNotification.Name(rawValue: NotificationKey.nextQuestion),
            object: self, userInfo: nil )
    }
}

