//
//  SettingsViewController.swift
//  Racing game
//
//  Created by Артём Симан on 1.04.22.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBAction func close(_ sender: Any) {
        navigationController?.popToRootViewController( animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
}
