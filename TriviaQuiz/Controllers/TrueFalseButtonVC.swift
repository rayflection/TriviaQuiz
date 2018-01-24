//
//  TrueFalseButtonVC.swift
//  TriviaQuiz
//
//  Created by Mike Yost on 1/22/18.
//  Copyright © 2018 CageFreeSoftware. All rights reserved.
//

import UIKit

class TrueFalseButtonVC: UIViewController {
    var scoreKeeper:ScoreKeeper?

    // @TODO - make outlets to T/F buttons, set font color via uiConfig.
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // -------------------------------------
    // @TODO:  write another one for multiple choice questions, which shows
    //        all the possible answers.
    //
    // MARK: button handlers
    @IBAction private func trueTapped(_ sender: Any) {
        if scoreKeeper != nil {
            scoreKeeper!.handleTrue()
        }
    }
    @IBAction private func falseTapped(_ sender: Any) {
        if scoreKeeper != nil {
            scoreKeeper!.handleFalse()
        }
    }

}
