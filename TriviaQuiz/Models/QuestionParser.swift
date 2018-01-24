//
//  QuestionParser.swift
//  TriviaQuiz
//
//  Created by Mike Yost on 1/18/18.
//  Copyright © 2018 CageFreeSoftware. All rights reserved.
//

import Foundation

class QuestionParser {
    
    static func parseList(_ data:[NSDictionary]) -> [QuestionModel] {
        var questions:[QuestionModel]=[];
        //let cats:NSMutableSet = []
        for datum:NSDictionary in data  {
            let model = QuestionParser.parse(datum)
            questions.append(model)
            //cats.add(model.category)
        }
        //print ("cats: \(cats)")
        return questions
    }
    static func parse (_ data:NSDictionary) -> QuestionModel {
        let model = QuestionModel()
        if let temp = data["category"] as! String? {
            model.category = temp
        }
        if let temp = data["correct_answer"] as! String? {
            model.correct_answer = temp
        }
        if let temp = data["question"] as! String? {
            model.question = temp.unHTML()
        }
        if let temp = data["difficulty"] as! String? {
            print (temp)
            model.difficulty = QuestionDifficulty.parseDifficulty(temp)
        }
        if let temp = data["type"] as! String? {
            if temp.lowercased().range(of: "boolean") != nil {
                model.type =  QuizTypeEnum.boolean
            }
        }
        return model
    }
    

}


