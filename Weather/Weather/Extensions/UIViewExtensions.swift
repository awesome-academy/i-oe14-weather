//
//  UIViewExtensions.swift
//  Weather
//
//  Created by minh duc on 2/19/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit

extension UIView {
    convenience init(width: CGFloat, height: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
    }
    
    func scaleCornerRadius(_ ratio: CGFloat) {
        layer.cornerRadius = ratio * bounds.width
    }
    
    func setCornerRadius(_ radius: CGFloat, border width: CGFloat = 0, color: UIColor = .white) {
        layer.cornerRadius = radius
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    func dropShadow(_ color: UIColor, offSet: CGSize, opacity: Float = 0, radius: CGFloat = 0) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offSet
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
    }
}

extension UISearchBar {
    func setTextFieldColor(_ color: UIColor) {
        let textField = value(forKey: "searchField") as? UITextField
        textField?.textColor = color
    }
}

extension UITableView {
    func reloadContent() {
        self.contentOffset.y = 0
    }
}
