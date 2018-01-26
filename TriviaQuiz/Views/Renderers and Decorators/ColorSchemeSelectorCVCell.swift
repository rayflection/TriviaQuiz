//
//  ColorSchemeSelectorCVCell.swift
//  TriviaQuiz
//
//  Created by Mike Yost on 1/25/18.
//  Copyright © 2018 CageFreeSoftware. All rights reserved.
//

import UIKit

class ColorSchemeSelectorCVCell: UICollectionViewCell {
    
    @IBOutlet weak var colorButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    var colorScheme:ColorScheme?
    
    func render(scheme:ColorScheme.SchemeName, row:Int) {
        let scheme = ColorSchemeFactory.gimmaAScheme(scheme)
        colorScheme = scheme
        self.backgroundColor = scheme.darkGradientTop
        
        nameLabel.text = scheme.scheme.rawValue
        nameLabel.textColor = scheme.titleFontColor
        
        colorButton.tag = row
    }
    @IBAction func colorButtonTapped(_ sender: Any) {
        if let schemeName = colorScheme?.scheme {
            UIConfigFactory.setCurrentConfigScheme(schemeName)
            NotificationCenter.default.post(
                name: NSNotification.Name(rawValue: NotificationKey.colorSchemeChanged),
                object: self, userInfo: nil )
        }
    }
}
