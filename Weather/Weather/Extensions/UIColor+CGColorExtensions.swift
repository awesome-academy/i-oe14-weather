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
    
    static let sunny = UIColor(hex: 0xFE9928)
    static let snow = UIColor(hex: 0x5F6AF4)
    static let rain = UIColor(hex: 0x60D7B1)
    static let thunder = UIColor(hex: 0x9072EE)
    static let wind = UIColor(hex: 0xFEDE82)
    static let cloudy = UIColor(hex: 0x7689D6)
}

extension CGColor {
    static let sunny = UIColor.sunny.cgColor
    static let snow = UIColor.snow.cgColor
    static let rain = UIColor.rain.cgColor
    static let thunder = UIColor.thunder.cgColor
    static let wind = UIColor.wind.cgColor
    static let cloudy = UIColor.cloudy.cgColor
}
