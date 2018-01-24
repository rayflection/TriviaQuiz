//
//  SplashVC.swift
//  TriviaQuiz
//
//  Created by Mike Yost on 1/18/18.
//  Copyright © 2018 CageFreeSoftware. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {

    var config:QuizConfig?
    
    private var chooserVC:ConfigurationSelectorVC?
    
    @IBOutlet private weak var quizDescription: UILabel!
    @IBOutlet private weak var beginButton: UIButton!
    @IBOutlet private weak var wrapperView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
    }

    private func render() {
        styleWrapperView()
        renderDescription()
    }
    private func styleWrapperView() {
        let uiConfig = UIConfigFactory.getCurrentConfig()
        
        view.backgroundColor = uiConfig.colorScheme.darkGradientTop
        wrapperView.layer.cornerRadius = uiConfig.layerSizes.cornerRadius
        wrapperView.layer.borderWidth = uiConfig.layerSizes.borderWidth
        wrapperView.layer.borderColor = uiConfig.colorScheme.gradientBorder.cgColor
    }
    
    private func renderDescription() {
        if let req = config?.request {
            let count = req.count
            let type = req.type.description()
            let diff = req.difficulty.rawValue
            quizDescription.text = "You will be presented with \(count ) \(diff) \(type ) question\(count==1 ? "":"s")."
        }
    }
    
    // ----------------------------
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "presentConfigSelectorPopupVC" {
            if let selectorVC = segue.destination as? ConfigurationSelectorVC {
                chooserVC = selectorVC
                chooserVC?.request = config?.request
                
                let handler : (QuizConfigRequest?) -> Void = handleNewRequestConfig
                chooserVC?.callbackHandler = handler
            }
        }
    }
    
    private func handleNewRequestConfig(newRequest: QuizConfigRequest?) {
        chooserVC?.dismiss(animated: false, completion: nil)
        if let chosen = newRequest {
            config?.request = chosen
            render()
        }
    }
    
    @IBAction private func beginTapped(_ sender: UIButton) {
        NotificationCenter.default.post(
            name: NSNotification.Name(rawValue: NotificationKey.dismissSplash),
            object: self, userInfo: ["request" : config?.request as Any])
    }
}
