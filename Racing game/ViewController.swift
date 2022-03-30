//
//  ViewController.swift
//  Racing game
//
//  Created by Артём Симан on 28.03.22.
//

import UIKit

class ViewController: UIViewController {
    
    private func ddd() {
        //
    }
    
    
    @IBOutlet weak var menuWidth: NSLayoutConstraint!
    
    @IBOutlet weak var menuContainer: UIView!
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBAction func startGame(_ sender: Any) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.showAlert (withTitle: "Начало игры",
                            message: "Пароль для входа в игру",
                            button: "Ок",
                            handler: {  _ in
                                self?.ddd()
            },
                             textFieldHandler: { [weak self] textField in
                let password = textField.text ?? ""
                
                if password == "11111" {
                    // go next screen
                } else {
                    self?.showAlert()
                }
            })
        }
    }
    
    @objc
    private func dismissBlur() {
        UIView.animate(withDuration: 1) {
            self.blurView.isHidden = true
            self.blurView.isUserInteractionEnabled = false
            self.menuWidth.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    
    @IBAction func menuButton(_ sender: Any) {
        
        UIView.animate(withDuration: 1) {
            self.blurView.isHidden = false
            self.blurView.isUserInteractionEnabled = true
          
            self.menuWidth.constant = 300
            self.view.layoutIfNeeded()
    
        }
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.title = "Racing Game"
        menuWidth.constant = 0
        blurView.isHidden = true
        
    }

}

