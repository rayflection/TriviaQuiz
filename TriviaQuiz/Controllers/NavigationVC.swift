//
//  ViewController.swift
//  TriviaQuiz
//
//  Created by Mike Yost on 1/18/18.
//  Copyright © 2018 CageFreeSoftware. All rights reserved.
//

import UIKit

//
//  X write tests
//    x  config
//    x  data service
//    x  question parser
//    x  scoreKeeper
//    x  question model
//    x  results model
//    x  utils and extensions?
//
//  x Check into github, create and merge into a dev branch. Testing Xcode.
//
//  FUTURE:
//   choose a categroy of questions in the ConfigurationVC - Later.
//   let user choose color scheme
//   let user specify if they're left handed, swap location of Ok/Cancel, and T/F buttons
//
// x  Better int values for the Difficulty enum
// x  Runtime configuration: choose a categroy of questions, choose difficulty,
//      possibly embedded in the SplashVC
// x  FIND some way to show difficulty.
// x  get values from Config
// x  pretty up the splash page, gradient or something.
// x Find all the force unwraped optional, and use "if let foo = optional?.someMethod {"
//     or "guard foo = optional?   {  } else { }
// x thumbs diddling doesn't belong in the ResultsVC, it belongs in a decorator or renderer
// x background colors and gradients
// x button borders and bevels, esp the question "card" - make it float with a drop shadow.
//  HTML cleanup Pod?
//

class NavigationVC: UIViewController {
    
    var quizConfig:QuizConfig?
    var questionVC:QuestionVC?
    var scoreKeeper = ScoreKeeper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNotifications()
        generateQuizConfig()
        generateUIConfig()
        playAgain()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "presentSplashVC" {
            let splashVC = segue.destination as? SplashVC
            splashVC?.config = quizConfig
        } else if segue.identifier == "embedQuestionVC" {
            questionVC = segue.destination as? QuestionVC
        } else if segue.identifier == "presentResultsVC" {
            let resultVC = segue.destination as? ResultsVC
            resultVC?.result = scoreKeeper.resultModel
        }
    }
    
    private func configNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.playAgain),
                                               name: Notification.Name(rawValue: NotificationKey.playAgain),
                                               object:nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.quizDone),
                                               name: Notification.Name(rawValue: NotificationKey.quizDone),
                                               object:nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.dismissSplash),
                                               name: Notification.Name(rawValue: NotificationKey.dismissSplash),
                                               object:nil)
    }
    private func generateUIConfig() {
       //UIConfigFactory.setCurrentConfigScheme(.red)  // comment out to use default color scheme
    }
    private func generateQuizConfig() {
        quizConfig = QuizConfig()
    }
    // -------------------------------------------
    // MARK: - navigation handlers
    @objc private func dismissSplash(aNotif:Notification) {
        popNav()
        if let dictionary = aNotif.userInfo as NSDictionary?, let configRequest=dictionary["request"] as? QuizConfigRequest {
            quizConfig = QuizConfig(request: configRequest)
        } else {
            quizConfig = QuizConfig()
        }
        retrieveData()
   }
    @objc private func quizDone() {
        performSegue(withIdentifier: "presentResultsVC", sender: nil)
    }
    @objc private func playAgain() {
        popNav()
        performSegue(withIdentifier: "presentSplashVC", sender: nil)
    }
    private func popNav() {
        if navigationController != nil {
            navigationController?.popToRootViewController(animated: false)
        }
    }
    // MARK: - Data
    private func retrieveData() {
        if let quizConfig = quizConfig {
        QuizDataService().fetchData( with: quizConfig) {
            (data, errorMessage) ->Void in
            if data != nil {
                self.handleNewData(questionList: data!)
                //self.apologize(title: "Foo", message: "Bar") // uncomment me for testing, since fetch never fails ;-)
            }
            else if errorMessage != nil {
                self.apologize(title: "Error Retrieving Quiz Data", message: errorMessage!)
            } else {
                self.apologize(title: "Error Retrieving Quiz Data", message:"No data, no error message.")
            }
        }
        }
    }
    private func handleNewData(questionList:[NSDictionary]) {
        configQuestionVC(questionList: QuestionParser.parseList(questionList))
    }
    private func configQuestionVC(questionList:[QuestionModel]) {
        scoreKeeper.questionList = questionList
        if let questionVC = questionVC {
            questionVC.config( questionList, scoreKeeper)
            questionVC.beginQuiz()
        }
    }
    private func apologize(title:String, message:String) {
        let alert = UIAlertController(title: title,
                                    message: message+"\n\n Sorry about that.\n Please try again later.",
                             preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: UIAlertActionStyle.cancel,
                                    handler: nil))
        self.present(alert, animated: false, completion: nil)
    }
}
