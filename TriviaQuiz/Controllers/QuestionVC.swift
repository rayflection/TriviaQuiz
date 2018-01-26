//
//  QuestionVC.swift
//  TriviaQuiz
//
//  Created by Mike Yost on 1/18/18.
//  Copyright © 2018 CageFreeSoftware. All rights reserved.
//

import UIKit

class QuestionVC: BaseVC {

    var questionList:[QuestionModel] = []
    var scoreKeeper:ScoreKeeper?
    var responseHandler:TrueFalseButtonVC?
    @IBOutlet private weak var quizCategoryLabel: UILabel!
    @IBOutlet private weak var questionLabel: UILabel!
    @IBOutlet private weak var currentCountLabel: UILabel!
    @IBOutlet private weak var gradBehindQuestion: UIView!


    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.nextQuestion),
                                               name: NSNotification.Name(rawValue: NotificationKey.nextQuestion),
                                               object:nil)
    }
    func removeGradientSubviewsFrom(view: UIView) {
        var deathRow:[UIView] = []
        for sub in view.subviews {
            if sub is GradientView {
                deathRow.append(sub)
            }
        }
        for sub in deathRow {
            print("Killing \(sub)")
            sub.removeFromSuperview()
        }
    }
    @objc override func styleBackgrounds() {
        let uiConfig = UIConfigFactory.getCurrentConfig()
        print("Questions configging to color: \(uiConfig.colorScheme.scheme.rawValue)")
        
        view.backgroundColor = uiConfig.colorScheme.darkGradientTop
        print("Question view bg is : \(uiConfig.colorScheme.darkGradientTop)")
        
        let gradientView = GradientView(frame: self.view.bounds,
                                        top:uiConfig.colorScheme.darkGradientTop,
                                        bottom:uiConfig.colorScheme.darkGradientBottom)
        
        removeGradientSubviewsFrom(view: self.view)
        
        self.view.insertSubview(gradientView, at: 0)
        
        let questionGrad = GradientView(frame: gradBehindQuestion.bounds,
                                        top:uiConfig.colorScheme.lightGradientTop,
                                        bottom:uiConfig.colorScheme.lightGradientBottom)
        
        if let gbq = gradBehindQuestion {
            removeGradientSubviewsFrom(view: gbq)
        }
        
        gradBehindQuestion.insertSubview(questionGrad, at: 0)

        questionGrad.layer.cornerRadius = uiConfig.layerSizes.cornerRadius
        gradBehindQuestion.layer.cornerRadius = questionGrad.layer.cornerRadius
        questionGrad.layer.borderWidth = uiConfig.layerSizes.borderWidth
        gradBehindQuestion.layer.borderWidth = questionGrad.layer.borderWidth
        questionGrad.layer.borderColor = uiConfig.colorScheme.gradientBorder.cgColor
        gradBehindQuestion.layer.borderColor = questionGrad.layer.borderColor
        
        quizCategoryLabel.textColor = uiConfig.colorScheme.titleFontColor
        currentCountLabel.textColor = quizCategoryLabel.textColor
        view.setNeedsDisplay()
    }
    func config(_ list:[QuestionModel],_ scoreKeep:ScoreKeeper) {
        styleBackgrounds()
        questionList = list
        scoreKeeper = scoreKeep
        responseHandler?.scoreKeeper = scoreKeep
    }
    func beginQuiz() {
        renderQuestion(0)
    }
    
    // MARK: - internal
    private func renderQuestion(_ qnum:Int) {
        assert(qnum >= 0 && qnum < questionList.count, "invalid question number \(qnum)" )
        if let scoreKeeper = scoreKeeper {
            scoreKeeper.currentQuestionIndex = qnum
            
            questionLabel.text = questionList[qnum].question
            renderCategoryLabel(qnum)
            renderCounterLabel(qnum)
        }
    }
    private func renderCategoryLabel(_ questionNumber: Int) {
        if scoreKeeper != nil {
            quizCategoryLabel.text = scoreKeeper?.questionList[questionNumber].category
        }
    }
    private func renderCounterLabel(_ questionNumber: Int) {
        currentCountLabel.text = "\(1+questionNumber) of \(questionList.count)"
    }
    // ------------------------------------
    @objc private func nextQuestion() {
        if let qnum = scoreKeeper?.currentQuestionIndex {
            renderQuestion(qnum)
        }
    }

    // MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedTrueFalseButtonVC" {
            responseHandler = segue.destination as? TrueFalseButtonVC
        }
    }
}
