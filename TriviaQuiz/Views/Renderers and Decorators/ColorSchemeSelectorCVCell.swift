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
    func render(scheme:ColorScheme.SchemeName) {
        let col = ColorSchemeFactory.gimmaAScheme(scheme)
        self.backgroundColor = col.darkGradientTop
        
        colorButton.setTitleColor(col.titleFontColor, for: UIControlState.normal)
        colorButton.setTitle(scheme.rawValue, for: UIControlState.normal)
    }
    @IBAction func colorButtonTapped(_ sender: Any) {
        let button = sender as? UIButton
        print("button tag = \(String(describing: button?.tag))")
    }
}
