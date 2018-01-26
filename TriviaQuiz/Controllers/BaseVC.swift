//
//  BaseVC.swift
//  TriviaQuiz
//
//  Created by Mike Yost on 1/25/18.
//  Copyright © 2018 CageFreeSoftware. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configNotifications()
    }
    
    private func configNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.styleBackgrounds),
                                               name: Notification.Name(rawValue: NotificationKey.colorSchemeChanged),
                                               object:nil)
    }

    @objc func styleBackgrounds() {
        // Highly recommended sub-views override this
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
