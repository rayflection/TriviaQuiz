//
//  ColorSchemeSelectorVC.swift
//  TriviaQuiz
//
//  Created by Mike Yost on 1/25/18.
//  Copyright © 2018 CageFreeSoftware. All rights reserved.
//

import UIKit

class ColorSchemeSelectorVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var data:[ColorScheme.SchemeName]=ColorScheme.SchemeName.enumerateUserChooseable

    // MARK:  Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorSchemeSelectorCVCell", for: indexPath) as! ColorSchemeSelectorCVCell
        
        let scheme = data[indexPath.row]
        cell.render(scheme: scheme, row:indexPath.row)

        return cell
    }
}
