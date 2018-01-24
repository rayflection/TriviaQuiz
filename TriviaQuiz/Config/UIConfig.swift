//
//  UIConfig.swift
//  TriviaQuiz
//
//  Created by Mike Yost on 1/22/18.
//  Copyright © 2018 CageFreeSoftware. All rights reserved.
//

import UIKit

struct ColorScheme {
    enum SchemeName:String {
        case black  = "Black"
        case brown  = "Brown"
        case blue   = "Blue"
        case red    = "Red"
        case white  = "White"
        case clear  = "Clear"
        case custom = "Custom"      // Roll your own
    }
    var scheme:SchemeName = .clear
    var darkGradientTop:UIColor=UIColor.clear
    var darkGradientBottom:UIColor=UIColor.clear
    var lightGradientTop:UIColor=UIColor.clear
    var lightGradientBottom:UIColor=UIColor.clear
    var gradientBorder:UIColor=UIColor.clear
    var titleFontColor:UIColor=UIColor.black
    
    init() {
    }   // return all clear as useless defaults to avoid opnoxtionals
    init(scheme:SchemeName,
         darkGradTop:UIColor,
         darkGradBottom:UIColor,
         lightGradTop:UIColor,
         lightGradBottom:UIColor,
         gradBorder:UIColor,
         titleFontCol:UIColor
        )
    {
        self.scheme = scheme
        darkGradientTop = darkGradTop
        darkGradientBottom = darkGradBottom
        lightGradientTop = lightGradTop
        lightGradientBottom = lightGradBottom
        gradientBorder = gradBorder
        titleFontColor = titleFontCol
    }
}
class ColorSchemeFactory {
    static func defaultScheme()  -> ColorScheme {
        return gimmaAScheme(.brown)
    }
    
    static func gimmaAScheme(_ scheme:ColorScheme.SchemeName) -> ColorScheme {
        switch scheme {
        // reminder: beauty is in the eye of the beholder, uglyness too
        case .black :
            return ColorScheme(
             scheme:scheme,
             darkGradTop:#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
             darkGradBottom:#colorLiteral(red: 0.4078193307, green: 0.4078193307, blue: 0.4078193307, alpha: 1),
             lightGradTop:#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1),
             lightGradBottom:#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),
             gradBorder:#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
             titleFontCol:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            )

        case .brown :
            return ColorScheme(
                scheme:scheme,
                darkGradTop: #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1),
                darkGradBottom: #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1),
                lightGradTop: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1),
                lightGradBottom: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1),
                gradBorder: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),
                titleFontCol: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            )
        case .red :
            return ColorScheme(
                scheme:scheme,
                darkGradTop: #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1),
                darkGradBottom: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1),
                lightGradTop: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 0.3268462724),
                lightGradBottom:#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 0.3268462724),
                gradBorder: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                titleFontCol:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
           )
        case .blue :
            return ColorScheme(
                scheme:scheme,
                darkGradTop: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1),
                darkGradBottom: #colorLiteral(red: 0.2285774887, green: 0.4654447115, blue: 0.6333781109, alpha: 1),
                lightGradTop: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),
                lightGradBottom:#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),
                gradBorder: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                titleFontCol:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            )
        case .white:
            return ColorScheme(
                scheme: .white,
                darkGradTop: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                darkGradBottom: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                lightGradTop: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                lightGradBottom: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                gradBorder: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                titleFontCol: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            )
        default:
            return ColorScheme()
        }
    }
}

struct LayerSizes {
    let cornerRadius = CGFloat(15)
    let borderWidth  = CGFloat(2)
    // Font sizes?
}

struct UIConfig {
    var colorScheme = ColorSchemeFactory.defaultScheme()
    var layerSizes = LayerSizes()
    init() {}
    init(scheme:ColorScheme.SchemeName) {
        colorScheme = ColorSchemeFactory.gimmaAScheme(scheme)
    }
}

class UIConfigFactory {
    
    static private var currentConfig = UIConfig()
    
    static func setCurrentConfigScheme(_ scheme:ColorScheme.SchemeName) {
        currentConfig.colorScheme = ColorSchemeFactory.gimmaAScheme(scheme)
    }
    
    static func getCurrentConfig() -> UIConfig {
        return currentConfig
    }
}
