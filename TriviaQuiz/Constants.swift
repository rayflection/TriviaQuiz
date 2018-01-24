//
//  Constants.swift
//  CageFreeSoftware
//
//  Created by Mike Yost on 1/18/17.
//  Copyright © 2017 CageFreeSoftware. All rights reserved.
//

import Foundation
import UIKit

struct NotificationKey {
    static let playAgain             = "kPlayAgainRequestNotifKey"
    static let quizDone              = "kQuizDoneNotifKey"
    static let nextQuestion          = "kNextQuestionNotifKey"
    static let dismissSplash         = "kDismissSplashNotifKey"
}

// worth putting in a .plist?
struct TableViewRowHeights {
    static let ROW_HEIGHT_PHONE = CGFloat(66.0)
    static let ROW_HEIGHT_PAD   = CGFloat(88.0)
}
struct ScoringConstants {
    static let LAME_SCORE_THRESHOLD = Double(0.5)
}
