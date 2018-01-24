//
//  QuizDataService.swift
//  TriviaQuiz
//
//  Created by Mike Yost on 1/18/18.
//  Copyright © 2018 CageFreeSoftware. All rights reserved.
//

import Foundation
import Alamofire

class QuizDataService {

    func fetchData( with config: QuizConfig,
                    completion:  @escaping ([NSDictionary]?, String?) -> Void
        )
    {
        print("config-urlString: \(config.getUrlString())")
        //
        // What does this do when it fails, like with a bad URL?
        //
        let foo =
        Alamofire.request(config.getUrlString(), method: .get, parameters: nil, encoding: JSONEncoding.default)
            
        foo.responseJSON { response in
                switch response.result {
                case .success(let result) :
                    if let JSON = result as? NSDictionary {
                        if let questions = JSON["results"] as? [NSDictionary] {
                            completion(questions, nil)
                        }
                    }
                case .failure(let error) :
                        completion(nil,error.localizedDescription)
                }
        }
    }
}
