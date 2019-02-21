//
//  AlertViewControllerExtension.swift
//  Weather
//
//  Created by minh duc on 2/21/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit

protocol AlertViewController { }

extension AlertViewController where Self: UIViewController {
    func showAlertView(title: String?, message: String?, cancelButton: String?, otherButton: String?, action: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let cancelTitle = cancelButton {
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
        }
        
        if let otherTitle = otherButton {
            let otherAction = UIAlertAction(title: otherTitle, style: .default) { _ in
                action?()
            }
            alertController.addAction(otherAction)
        }
        present(alertController, animated: true, completion: nil)
    }
    
    func showErrorMessage(message: String?) {
        showAlertView(title: Constants.warning, message: message, cancelButton: Constants.ok, otherButton: nil, action: nil)
    }
}
