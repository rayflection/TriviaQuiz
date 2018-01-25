//
//  ColorSchemeSelectorVC.swift
//  TriviaQuiz
//
//  Created by Mike Yost on 1/25/18.
//  Copyright © 2018 CageFreeSoftware. All rights reserved.
//

import UIKit

class ColorSchemeSelectorVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    var data:[ColorScheme.SchemeName]=ColorScheme.SchemeName.enumerateUserChooseable
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
    }

    func render() {
        collectionView.reloadData()
    }
    
    // --------------------------------
    // MARK: Collection View protocols
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ColorSchemeSelectorCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorSchemeSelectorCVCell", for: indexPath) as! ColorSchemeSelectorCVCell
        cell.render(scheme:data[indexPath.row])
        cell.colorButton.tag = indexPath.row
        return cell
    }
}
