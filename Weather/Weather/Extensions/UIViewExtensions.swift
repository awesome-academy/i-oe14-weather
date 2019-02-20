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
}
