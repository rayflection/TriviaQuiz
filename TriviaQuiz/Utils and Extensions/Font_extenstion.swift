//
//  Font_extenstion.swift
//  TriviaQuiz
//
//  Created by Mike Yost on 1/22/18.
//  Copyright © 2018 CageFreeSoftware. All rights reserved.
//

import UIKit

extension UIFont {
    var bold: UIFont {
        return with(traits: .traitBold)
    }
    
    var italic: UIFont {
        return with(traits: .traitItalic)
    }
    
    var boldItalic: UIFont {
        return with(traits: [.traitBold, .traitItalic])
    }
    
    func with(traits: UIFontDescriptorSymbolicTraits) -> UIFont {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(traits)
            else {
                return self
        }
        return UIFont(descriptor: descriptor, size: 0)
    }
}
