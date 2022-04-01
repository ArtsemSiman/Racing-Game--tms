//
//  ViewController.swift
//  Racing game
//
//  Created by Артём Симан on 28.03.22.
//

import UIKit

class ViewController: UIViewController {
    
    var openGameHandler: ((UIAlertAction) -> Void) =  {_ in
        //
    }
    
    lazy var pinHandler: ((UITextField) -> Void) =  { [weak self] textField in
        let password = textField.text ?? ""
        
        if password == "11111" {
            // go next screen
        } else {
            self?.showAlert()
        }
    }
    var isMenuShown = false
    
    @IBOutlet weak var menuWidth: NSLayoutConstraint!
    
    @IBOutlet weak var menuContainer: UIView!
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBAction func startGame(_ sender: Any) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.showAlert (withTitle: "Начало игры",
                             message: "Пароль для входа в игру",
                             button: "Ок",
                             handler: self?.openGameHandler,
                             textFieldHandler: self?.pinHandler)
        }
    }
    
    @objc
    private func dismissBlur() {
        UIView.animate(withDuration: 1) {
            self.menuWidth.constant = 0
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.blurView.isHidden = true
            self.blurView.isUserInteractionEnabled = false
        }
        self.isMenuShown  = false
    }
    
    
    @IBAction func menuButton(_ sender: Any) {
        if isMenuShown {
            dismissBlur()
            return
        }
        self.blurView.isHidden = false
        self.blurView.isUserInteractionEnabled = true
        UIView.animate(withDuration: 1) {
            self.menuWidth.constant = 300
            self.view.layoutIfNeeded()
        }
        menuContainer.isUserInteractionEnabled = true
        isMenuShown = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Racing Game"
        menuWidth.constant = 0
        blurView.isHidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissBlur))
        blurView.addGestureRecognizer(tapGesture)
        blurView.isUserInteractionEnabled = false
        
        settings.shared.userName = "Артём"
       
        settings.shared.speed = 20
        
        FileStorage.saveImage(UIImage(named:"construction"), withName: "construction")
        FileStorage.saveImage(UIImage(named:"conus"), withName: "conus")
        FileStorage.saveImage(UIImage(named:"conus"), withName: "conus")
        FileStorage.saveImage(UIImage(named:"tree"), withName: "tree")
    }
    
}

