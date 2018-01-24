//
//  QuizConfig.swift
//  TriviaQuiz
//
//  Created by Mike Yost on 1/18/18.
//  Copyright © 2018 CageFreeSoftware. All rights reserved.
//

import Foundation

enum QuizTypeEnum:String {
    case boolean  = "boolean"
    case multiple = "multiple"     // NIY
    
    func description() -> String {
        switch self {
            case .boolean:  return "True or False"
            case .multiple: return "Multiple Choice"
        }
    }
    func parameter() -> String {
        switch self {
            case .boolean:  return "boolean"
            case .multiple: return "multiple"
        }
    }
}
struct QuizConfigRequest {
    var count=10
    var type = QuizTypeEnum.boolean
    var difficulty = QuestionDifficulty.random
}
class QuizConfig {
    var request = QuizConfigRequest()
    public static let minQuestionCount = 1
    public static let maxQuestionCount = 50
    
    private var urlString:String=""
    
    init() {
        setDefaults()
    }
    
    init(request:QuizConfigRequest) {
        setDefaults()
        var sanitizedRequest = request
        if request.count < QuizConfig.minQuestionCount  {
            sanitizedRequest.count = QuizConfig.minQuestionCount
        } else if request.count > QuizConfig.maxQuestionCount {
            sanitizedRequest.count = QuizConfig.maxQuestionCount
        }

        buildURLString(sanitizedRequest)
        self.request = sanitizedRequest
    }
    
    private func setDefaults() {
        buildURLString(request)
    }
    func getUrlString() -> String {
        return urlString
    }
    private func buildURLString(_ request:QuizConfigRequest)
    {
        // @TODO: get url base from a plist somewhere
        var url = "https://opentdb.com/api.php?amount=\(request.count)&type=\(request.type.parameter())"
        if request.difficulty != .random {
            url += "&difficulty=\(request.difficulty.rawValue)"
        }
        urlString = url
    }
}

