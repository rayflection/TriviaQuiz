//
//  SplashVC.swift
//  TriviaQuiz
//
//  Created by Mike Yost on 1/18/18.
//  Copyright © 2018 CageFreeSoftware. All rights reserved.
//

import UIKit

class SplashVC: BaseVC {

    var config:QuizConfig?
    
    private var chooserVC:ConfigurationSelectorVC?
    private var colorSelectorVC:ColorSchemeSelectorVC?
    
    @IBOutlet private weak var quizDescription: UILabel!
    @IBOutlet private weak var beginButton: UIButton!
    @IBOutlet private weak var wrapperView: UIView!
    @IBOutlet         weak var versionLabel: UILabel!
    @IBOutlet         weak var colorSchemeSelectorButton: UIButton!
    @IBOutlet         weak var colorSchemeSelectorContainerView: UIView!
    @IBOutlet         weak var colorButtonAnchor: UIView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
    }

    private func render() {
        styleBackgrounds()
        renderDescription()
        renderVersion()
        renderColorSchemeSelectorButton()
    }
    @objc override func styleBackgrounds() {
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
    func renderVersion() {
        versionLabel.text = VersionService.getVersionString()
    }

    // MARK: Color scheme chooser stuff.
    func configColorSchemeSelectorButton() {
        colorSchemeSelectorButton.tag = 0
    }
    func renderColorSchemeSelectorButton() {
        configColorSchemeSelectorButton()
    }
    var gap = CGFloat(0)
    @IBAction func colorSchemeButtonTapped(_ sender: Any) {
        if gap < 1.0 {
            gap = self.colorSchemeSelectorContainerView.frame.origin.x -
                  self.colorButtonAnchor.frame.origin.x
        }
        
        if colorSchemeSelectorButton.tag == 0  {
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [],
                animations: {
                    let deltaX = CGFloat(
                        self.colorSchemeSelectorContainerView.frame.origin.x +
                        self.colorSchemeSelectorContainerView.frame.size.width -
                        self.colorButtonAnchor.frame.origin.x
                    )
                    self.colorSchemeSelectorButton.frame.origin.x -= (deltaX - self.gap)
                    self.colorSchemeSelectorContainerView.frame.origin.x -= deltaX
                }, completion: { (finished: Bool) in
                    self.colorSchemeSelectorButton.tag = 1 - self.colorSchemeSelectorButton.tag
                })
        } else {
            UIView.animate(withDuration: 0.25, delay: 0.0, options: [],
                animations: {
                    self.colorSchemeSelectorButton.frame.origin.x =
                        self.colorButtonAnchor.frame.origin.x - self.colorSchemeSelectorButton.frame.size.width
                    self.colorSchemeSelectorContainerView.frame.origin.x = self.colorButtonAnchor.frame.origin.x + self.gap
                }, completion: { (finished: Bool) in
                    self.colorSchemeSelectorButton.tag = 1 - self.colorSchemeSelectorButton.tag
                    if self.reDisplayColorChooser == true {
                        self.reDisplayColorChooser = false
                        self.colorSchemeButtonTapped(self.colorSchemeSelectorButton)
                    }
                })
        }
    }
    // MARK: Rotation support
    var reDisplayColorChooser=false
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        if colorSchemeSelectorButton.tag != 0 {
            reDisplayColorChooser = true
            self.performSelector(onMainThread: #selector(colorSchemeButtonTapped),
                                 with: colorSchemeSelectorButton,
                                 waitUntilDone: true)   // hide
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
        } else if segue.identifier == "embedColorSelectorVC" {
            if let colorVC = segue.destination as? ColorSchemeSelectorVC {
                colorSelectorVC = colorVC
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
