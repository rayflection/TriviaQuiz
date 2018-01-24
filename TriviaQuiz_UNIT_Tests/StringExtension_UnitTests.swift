//
//  StringExtension_UnitTests.swift
//  TriviaQuiz_UNIT_Tests
//
//  Created by Mike Yost on 1/24/18.
//  Copyright © 2018 CageFreeSoftware. All rights reserved.
//

import XCTest

class StringExtension_UnitTests: XCTestCase {
    
    func test_noChange() {
        XCTAssert("NOCHANGES".unHTML() == "NOCHANGES","Unexpected string change")
    }

    func test_replaceOneAmp() {
        XCTAssert("ABC&#039;DEF".unHTML() == "ABC'DEF","Amp not replaced")
    }
    
    func test_replaceMultipleAmps() {
        XCTAssert("ABC&#039;DEF&#039;GHJ".unHTML() == "ABC'DEF'GHJ","Amps not replaced")
    }

    func test_replaceOneQuote() {
        XCTAssert("ABC&quot;DEF".unHTML() == "ABC\"DEF","Quote not replaced")
    }

    func test_replaceMultipleQuotes() {
        XCTAssert("ABC&quot;DEF&quot;GHJ".unHTML() == "ABC\"DEF\"GHJ","Quotes not replaced")
    }

    func test_replaceOneQuoteAndOneAmp() {
        XCTAssert("ABC&quot;DEF&#039;GHJ".unHTML() == "ABC\"DEF'GHJ","Amp or Quote not replaced")
    }
    
    func test_replaceMultipleQuotesAndOneAmp() {
        XCTAssert("ABC&quot;DEF&#039;GHJ&quot;LMN".unHTML() == "ABC\"DEF'GHJ\"LMN")
    }
    
    func test_replaceOneQuoteAndMultipleAmps() {
        XCTAssert("ABC&#039;DEF&#039;GHJ&quot;LMN".unHTML() == "ABC'DEF'GHJ\"LMN")
    }
    
    func test_replaceMultipleQuotesAndMultipleAmps() {
        XCTAssert("ABC&#039;DEF&#039;GHJ&quot;LMN&quot;PQR".unHTML() == "ABC'DEF'GHJ\"LMN\"PQR")
   }
    
    func test_ignoreIncorrectlySpecifiedQuote() {
        XCTAssert("ABC&quotDEF".unHTML() == "ABC&quotDEF","Quote should not have been replaced")
        XCTAssert("ABCquot;DEF".unHTML() == "ABCquot;DEF","Quote should not have been replaced")
        XCTAssert("ABCquotDEF".unHTML()  == "ABCquotDEF", "Quote should not have been replaced")
    }
    
    func test_ignoreIncorrectlySpecifiedAmp() {
        XCTAssert("ABC&#039DEF".unHTML() == "ABC&#039DEF","Amp should not have been replaced")
        XCTAssert("ABC#039;DEF".unHTML() == "ABC#039;DEF","Amp should not have been replaced")
        XCTAssert("ABC&039;DEF".unHTML() == "ABC&039;DEF","Amp should not have been replaced")
    }
}
