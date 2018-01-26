//
//  VersionService.swift
//  TriviaQuiz
//
//  Created by Mike Yost on 1/26/18.
//  Copyright © 2018 CageFreeSoftware. All rights reserved.
//

import Foundation

class VersionService {
    
    static func getVersionString() -> String {
        let short = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        let ver   = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
        let df = DateFormatter()
        df.dateFormat = "MMM dd, yyyy HH:mm:ss"
        let date = df.string(from: Date())
        if let short = short, let ver = ver {
            var verString = "Version \(short) (\(ver)) - \(date)"
            #if DEBUG_HOME
                verString = "\(verString) (dev)"
            #endif
            return verString
        }
        return ""
    }
    
}
