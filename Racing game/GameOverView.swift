//
//  GameOverView.swift
//  Racing game
//
//  Created by Артём Симан on 21.04.22.
//

import UIKit

class GameOverView: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(back))
    }
    
    //MARK: - Methods
    @objc private func back (sender: AnyObject) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

