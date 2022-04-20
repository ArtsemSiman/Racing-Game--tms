//
//  UIViewController+Alert.swift
//  Racing game
//
//  Created by Артём Симан on 29.03.22.
//

import UIKit

extension UIViewController {
    
    
    func showAlert(withTitle title: String = "Ошибка",
                   message: String = "Неверный пароль",
                   button: String? = nil,
                   handler: ((UIAlertAction) -> Void)? = nil,
                   textFieldHandler: ((UITextField) -> Void)? = nil
    ) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        if let button = button {
            let action = UIAlertAction(title: button,
                                       style: .default
            ) {
                action in handler?(action)
                if let textField = alert.textFields?.first {
                    textFieldHandler?(textField)
                }
            }
            
            alert.addAction(action)
        }
        
        
        let cancelAction = UIAlertAction(title: "Закрыть",
                                         style: .cancel) { _ in
            print(alert.textFields?.first?.text)
        }
        
        alert.addAction(cancelAction)
        
        let eyeHadler: ((UITextField) -> ()) = { textField in
            textField.isSecureTextEntry.toggle()
        }
        
        let setupEye: ((UITextField) -> ()) = { textField in
            let tHeight = textField.frame.height
            let tWidth = textField.frame.width
            let eHeight = tHeight - 4
            let eWidth = eHeight * 1.5
            
            let eyeButton = UIButton(frame: CGRect(
                x: tWidth - eWidth - 4,
                y: 2,
                width: eWidth,
                height: eHeight
            ))
            
            eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
            eyeButton.alpha = 0
            eyeButton.addTarget(self, action: #selector(self.showText), for: .touchUpInside)
            textField.addSubview(eyeButton)
            UIView.animate(withDuration: 0.5, delay: 0, options: []) {
                eyeButton.alpha = 1
            }
        }
        
        if textFieldHandler != nil {
            alert.addTextField { textField in
                textField.placeholder = "пароль"
                textField.isSecureTextEntry = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    setupEye(textField)
                }
            }
        }
        
        
        self.present(alert, animated: true)
    }
    
    @objc
    func showText() {
        let alert = self.presentedViewController as? UIAlertController
        alert?.textFields?.first?.isSecureTextEntry.toggle()
    }
}
