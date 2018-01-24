//
//  ResultTVCell.swift
//  TriviaQuiz
//
//  Created by Mike Yost on 1/19/18.
//  Copyright © 2018 CageFreeSoftware. All rights reserved.
//

import UIKit

class ResultTVCell: UITableViewCell {
    @IBOutlet private weak var icon:  UIImageView!
    @IBOutlet weak var blurbLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    
    func render( result : ResultItem ) {
        if result.isCorrect {
            icon.image = #imageLiteral(resourceName: "greenPlus")       // @TODO: tie icon in with color scheme
        } else {
            icon.image = #imageLiteral(resourceName: "redMinus")
        }
        // @TODO: get font sizes from CONFIG
        let boldItalicFont = UIFont.boldSystemFont(ofSize: 18.0).boldItalic
        let correctAnswerATT = NSMutableAttributedString(string: result.correctAnswer+": ",
                                                     attributes: [NSAttributedStringKey.font: boldItalicFont] )
        let smallFont = UIFont.systemFont(ofSize: 15.0)
        let questionATT = NSAttributedString(string: result.question.unQuote(),
                                             attributes:[.font: smallFont, .foregroundColor: UIColor.lightGray]
        )
        correctAnswerATT.append(questionATT)
        blurbLabel.attributedText = correctAnswerATT
        renderDifficulty(result.difficulty)
    }
    private func renderDifficulty(_ difficulty:QuestionDifficulty) {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            difficultyLabel.text = difficulty.rawValue
        case .phone:
            if let initial = difficulty.rawValue.capitalized.first {
                difficultyLabel.text = String(initial)
            }
        default:
            return
        }
        switch difficulty {
            case .easy: difficultyLabel.textColor = UIColor.green
            case .medium: difficultyLabel.textColor = UIColor.blue
            case .hard: difficultyLabel.textColor = UIColor.red
        default:
            break
        }
    }
}


