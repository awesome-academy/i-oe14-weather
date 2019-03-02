//
//  UIColor+CGColorExtensions.swift
//  Weather
//
//  Created by minh duc on 2/25/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, a: Int = 0xFF) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(a) / 255.0
        )
    }
    
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
    
    static let wind = UIColor(hex: 0xFEDE82)
    static let humidity = UIColor(hex: 0x5F6AF4)
    static let uv = UIColor(hex: 0x7051F0)
    static let pressure = UIColor(hex: 0x5F6AF4)
    static let visibility = UIColor(hex: 0x80C2AB)
    static let sunrise = UIColor(hex: 0xFBED57)
    static let sunset = UIColor(hex: 0xFE9928)
}
