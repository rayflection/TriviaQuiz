//
//  GradientView.swift
//  TriviaQuiz
//
//  Created by Mike Yost on 1/20/18.
//  Copyright © 2018 CageFreeSoftware. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    private var colors = [UIColor.white.cgColor, UIColor.lightGray.cgColor]
    
    init(frame: CGRect, top:UIColor, bottom:UIColor) {
        super.init(frame: frame)
        colors = [top.cgColor, bottom.cgColor]
        setupView()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        guard let theLayer = self.layer as? CAGradientLayer else {
            return;
        }
        
        theLayer.colors = colors
        theLayer.locations = [0.0, 1.0]
        theLayer.frame = self.bounds
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    // --------------------------------
    static func removeGradientSubviewsFrom(view: UIView) {
        var deathRow:[UIView] = []
        for sub in view.subviews {
            if sub is GradientView {
                deathRow.append(sub)
            }
        }
        for sub in deathRow {
            sub.removeFromSuperview()
        }
    }
    
}

