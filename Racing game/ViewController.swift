//
//  ViewController.swift
//  Racing game
//
//  Created by Артём Симан on 28.03.22.
//

import UIKit
import FirebaseCrashlytics
import FirebaseAnalytics

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func photoButton(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Library", style: .default) { [weak self] _ in self?.openGallery()
        })
        alert.addAction(UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
            self?.openCamera()
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    var openGameHandler: ((UIAlertAction) -> Void) =  {_ in
        //
    }
    
    lazy var pinHandler: ((UITextField) -> Void) =  { [weak self] textField in
        let password = textField.text ?? ""
        
        if password == "111" {
            self?.performSegue(withIdentifier: "startGame", sender: self)
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
            
            let userInfo = [
              NSLocalizedDescriptionKey: NSLocalizedString("The request failed.", comment: ""),
              NSLocalizedFailureReasonErrorKey: NSLocalizedString("The response returned a 404.", comment: ""),
              NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Something wrong", comment: ""),
              "ProductID": "NO ID",
              "View": "MainView"
            ]

            let error = NSError.init(domain: NSCocoaErrorDomain,
                                     code: -1001,
                                     userInfo: userInfo)
            Crashlytics.crashlytics().record(error: error)
            
            Analytics.logEvent("startgame", parameters: nil)
            
            Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
              AnalyticsParameterItemID: "id-\(111)",
              AnalyticsParameterItemName: "start button",
              AnalyticsParameterContentType: "button",
            ])
            
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
        imageView.layer.cornerRadius = imageView.frame.height / 2
        
        imageView.image = FileStorage.getImage(withName: "userAvatar")
    }
    
}


// MARK: - Extension Open Camera & Gallary

private extension ViewController {
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: - Extension ImagePicker Delegate
 
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      if let pickedImage = info[.originalImage] as? UIImage {
          imageView.image = pickedImage
          FileStorage.saveImage(pickedImage, withName: "userAvatar")
      }
      picker.dismiss(animated: true, completion: nil)
  }
}
