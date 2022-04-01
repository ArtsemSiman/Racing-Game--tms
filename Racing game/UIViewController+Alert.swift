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
        
        if textFieldHandler != nil {
            alert.addTextField {
                textField in textField.placeholder = "пароль"
            }
        }
        
        
        self.present(alert, animated: true)
    }
}
