//
//  UIConfig_UnitTests.swift
//  TriviaQuizTests
//
//  Created by Mike Yost on 1/23/18.
//  Copyright © 2018 CageFreeSoftware. All rights reserved.
//

import XCTest

class UIConfig_UnitTests: XCTestCase {

    func test_UIConfig_Defaults() {
        let config = UIConfigFactory.getCurrentConfig()
        
        XCTAssert(config.colorScheme.scheme == ColorScheme.SchemeName.brown, "Default color scheme \(config.colorScheme.scheme) should be .brown \(ColorScheme.SchemeName.brown)")
        XCTAssert(config.layerSizes.borderWidth == CGFloat(2.0), "BorderWidth should be 2.0")
        XCTAssert(config.layerSizes.cornerRadius == CGFloat(15.0), "CornerRadius should be 15.0")
        
        let scheme = ColorScheme()
        XCTAssert(scheme.scheme == ColorScheme.SchemeName.clear, "Default scheme object type should be .clear")
    }
    func test_color_scheme_enum() {
        XCTAssert(ColorScheme.SchemeName.black.rawValue  == "Black", " Raw Black  should be 'Black'")
        XCTAssert(ColorScheme.SchemeName.brown.rawValue  == "Brown", " Raw Brown  should be 'Brown'")
        XCTAssert(ColorScheme.SchemeName.blue.rawValue   == "Blue",  " Raw Blue   should be 'Blue'")
        XCTAssert(ColorScheme.SchemeName.red.rawValue    == "Red",   " Raw Red    should be 'Red'")
        XCTAssert(ColorScheme.SchemeName.white.rawValue  == "White", " Raw White  should be 'White'")
        XCTAssert(ColorScheme.SchemeName.clear.rawValue  == "Clear", " Raw Clear  should be 'Clear'")
        XCTAssert(ColorScheme.SchemeName.custom.rawValue == "Custom"," Raw Custom should be 'Custom'")
    }

    
    func test_SetCurrentColorScheme_Indirectly() {
        let uiConfig = UIConfig(scheme:.blue)
        XCTAssert(uiConfig.colorScheme.scheme == .blue, "Color scheme should be blue")
        UIConfigFactory.setCurrentConfigScheme(uiConfig.colorScheme.scheme)
        let changedUiConfig = UIConfigFactory.getCurrentConfig()
        XCTAssert(changedUiConfig.colorScheme.scheme == .blue,"Current scheme should now be .blue")
        
        // reset to brown, otherwise it breaks other tests.  Mystery .
        UIConfigFactory.setCurrentConfigScheme(ColorScheme.SchemeName.brown)
    }
    
    func test_SetCurrentColorScheme_Directly() {
        let initialConfig = UIConfigFactory.getCurrentConfig()
        XCTAssert(initialConfig.colorScheme.scheme == .brown, "Initial scheme should be .brown")
        
        UIConfigFactory.setCurrentConfigScheme(.red)
        let changedUiConfig = UIConfigFactory.getCurrentConfig()
        XCTAssert(changedUiConfig.colorScheme.scheme == .red,"Current scheme should now be .red")
    }
    
    func test_scheme_clear() {
        let scheme = ColorScheme()
        XCTAssert(scheme.scheme == .clear, "Unspecified scheme should be .clear")
        XCTAssert(scheme.darkGradientTop == UIColor.clear,"darkGradientTop should be clear")
        XCTAssert(scheme.darkGradientBottom == UIColor.clear,"darkGradientBottom should be clear")
        XCTAssert(scheme.lightGradientTop == UIColor.clear,"lightGradientTop should be clear")
        XCTAssert(scheme.lightGradientBottom == UIColor.clear,"lightGradientBottom should be clear")
        XCTAssert(scheme.gradientBorder == UIColor.clear, "gradient border should be clear")
        XCTAssert(scheme.titleFontColor == UIColor.black, "Title font color should be black.")
    }
    func test_create_custom_scheme() {
        let scheme = ColorScheme(
            scheme:.custom,
            darkGradTop: #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1),
            darkGradBottom: #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1),
            lightGradTop: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1),
            lightGradBottom: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1),
            gradBorder: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),
            titleFontCol: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        )
        XCTAssert(scheme.darkGradientTop == #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1), "dark gradient top color wrong")
        XCTAssert(scheme.titleFontColor == #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), "title font color wrong")
    }
    
    func test_create_custom_scheme_with__uiColors() {
        let scheme = ColorScheme(
            scheme: .custom,
            darkGradTop: UIColor.red,
            darkGradBottom: UIColor.blue,
            lightGradTop: UIColor.darkGray,
            lightGradBottom: UIColor.orange,
            gradBorder: UIColor.yellow,
            titleFontCol: UIColor.green
        )
        XCTAssert(scheme.scheme == .custom, "scheme name should be .custom")
        XCTAssert(scheme.darkGradientTop == UIColor.red,"darkGradientTop should be red")
        XCTAssert(scheme.darkGradientBottom == UIColor.blue,"darkGradientBottom should be blue")
        XCTAssert(scheme.lightGradientTop == UIColor.darkGray,"lightGradientTop should be darkGray")
        XCTAssert(scheme.lightGradientBottom == UIColor.orange,"lightGradientBottom should be orange")
        XCTAssert(scheme.gradientBorder == UIColor.yellow, "gradient border should be yellow")
        XCTAssert(scheme.titleFontColor == UIColor.green, "Title font color should be green.")
    }
}
