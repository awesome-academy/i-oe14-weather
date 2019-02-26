//
//  UIViewControllerExtension.swift
//  Weather
//
//  Created by minh duc on 2/21/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit
import MBProgressHUD

extension UIViewController {    
    func showAlertView(title: String?, message: String?, cancelButton: String?, otherButtons: [String]? = nil,
                       type: UIAlertController.Style = .alert, cancelAction: (() -> Void)? = nil,
                       otherAction: ((Int) -> Void)? = nil) {
        let alertViewController = UIAlertController(title: title ,
                                                    message: message,
                                                    preferredStyle: type)
        
        if let cancelButton = cancelButton {
            let cancelAction = UIAlertAction(title: cancelButton, style: .cancel, handler: { (_) in
                cancelAction?()
            })
            alertViewController.addAction(cancelAction)
        }
        
        if let otherButtons = otherButtons {
            for (index, otherButton) in otherButtons.enumerated() {
                let otherAction = UIAlertAction(title: otherButton,
                                                style: .default, handler: { (_) in
                                                    otherAction?(index)
                })
                alertViewController.addAction(otherAction)
            }
        }
        present(alertViewController, animated: true, completion: nil)
    }
    
    func showErrorMessage(message: String?) {
        showAlertView(title: Constants.warning, message: message, cancelButton: Constants.ok, type: .alert)
    }
    
    func startLoading() {
        MBProgressHUD.showAdded(to: view, animated: true)
    }
    
    func stopLoading() {
        MBProgressHUD.hide(for: view, animated: true)
    }
}
