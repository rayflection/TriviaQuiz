//
//  ConfigurationSelectorVC.swift
//  TriviaQuiz
//
//  Created by Mike Yost on 1/22/18.
//  Copyright © 2018 CageFreeSoftware. All rights reserved.
//

import UIKit

class ConfigurationSelectorVC: UIViewController {

    var request:QuizConfigRequest?
    var callbackHandler:((QuizConfigRequest?) -> Void )?
    
    @IBOutlet weak var countSlider: UISlider!
    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var difficultyChooser: UISegmentedControl!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSliderValue()
        initSegmentValue()
        styleViews()
    }

    private func initSliderValue() {
        countSlider.minimumValue = Float(QuizConfig.minQuestionCount)
        countSlider.maximumValue = Float(QuizConfig.maxQuestionCount)
        if let num = request?.count {
            countSlider.value = Float(num)
            sliderMoved(self)
        }
    }
    
    private func initSegmentValue() {
        if let diff = request?.difficulty {
            difficultyChooser.selectedSegmentIndex = diff.order
        }
    }
    
    private func styleViews() {
        let uiConfig = UIConfigFactory.getCurrentConfig()

        let gradientView = GradientView(frame: self.view.bounds,
                                        top:uiConfig.colorScheme.lightGradientTop,
                                        bottom:uiConfig.colorScheme.lightGradientBottom)
        self.view.insertSubview(gradientView, at: 0)

        titleLabel.textColor = uiConfig.colorScheme.titleFontColor
        // @TODO: segment tint.
    }
    
    @IBAction func sliderMoved(_ sender: Any) {
        currentLabel.text = String(Int(countSlider.value))
    }

    @IBAction func okTapped(_ sender: Any) {
        request?.count = Int(countSlider.value)
        request?.difficulty = QuestionDifficulty.levelFor(position: difficultyChooser.selectedSegmentIndex)
        request?.count = Int(countSlider.value)

        if let handler = callbackHandler, let req = request {
            handler( req )
        }
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        if let handler = callbackHandler{
            handler( nil )
        }
    }
    
    
}
