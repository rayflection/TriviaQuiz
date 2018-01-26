//
//  ResultsVC.swift
//  TriviaQuiz
//
//  Created by Mike Yost on 1/19/18.
//  Copyright © 2018 CageFreeSoftware. All rights reserved.
//

import UIKit

class ResultsVC: BaseVC, UITableViewDelegate, UITableViewDataSource {

    var result:QuizResultsModel?
    
    @IBOutlet private weak var playAgainButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if result != nil && result!.results.count > 0 {
            styleBackgrounds()
            render()
        }
    }
    
    @objc override func styleBackgrounds() {
        let uiConfig = UIConfigFactory.getCurrentConfig()
        
        view.backgroundColor = uiConfig.colorScheme.darkGradientTop
        tableView.layer.cornerRadius = uiConfig.layerSizes.cornerRadius
        tableView.layer.borderWidth = uiConfig.layerSizes.borderWidth
        tableView.layer.borderColor = uiConfig.colorScheme.gradientBorder.cgColor
        titleLabel.textColor = uiConfig.colorScheme.titleFontColor
        scoreLabel.textColor = titleLabel.textColor
        playAgainButton.setTitleColor(titleLabel.textColor, for:UIControlState.normal)
    }
    private func render() {
        renderScore()
        tableView.reloadData()
    }
    private func renderScore() {
        scoreLabel.text = ResultDecorator.scoreWithAttitude(result)
    }
    
    // Mark: table delegate protocols
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:    return TableViewRowHeights.ROW_HEIGHT_PHONE
        case .pad:      return TableViewRowHeights.ROW_HEIGHT_PAD
        default:        return 0
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = result?.results.count {
            return count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        assert(result!.results.count>0 && indexPath.row < result!.results.count,"indexPath out of bounds")
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultTableViewCell") as! ResultTVCell
        if let results = result?.results {
            cell.render(result: results[indexPath.row])
        }
        return cell
    }

    // MARK: button handler
    @IBAction private func playAgainTapped(_ sender: Any) {
        NotificationCenter.default.post(
            name: NSNotification.Name(rawValue: NotificationKey.playAgain),
            object: self, userInfo: nil )
    }
}
