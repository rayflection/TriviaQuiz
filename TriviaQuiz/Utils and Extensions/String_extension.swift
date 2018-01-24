//
//  String_extension.swift
//  TriviaQuiz
//
//  Created by Mike Yost on 1/22/18.
//  Copyright © 2018 CageFreeSoftware. All rights reserved.
//

import Foundation

extension String {
    func unHTML() -> String {
        // Yo, intern!  extra credit, find a CocoaPod that does this for all html.
        return self.unQuote().unAmp()
    }
    func unQuote() -> String {
        return self.replacingOccurrences(of: "&quot;", with: "\"")
    }
    func unAmp() -> String {
        return self.replacingOccurrences(of: "&#039;", with: "'")
    }
}
