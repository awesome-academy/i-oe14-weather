//
//  DoubleExtensions.swift
//  Weather
//
//  Created by minh duc on 2/26/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import Foundation

extension Double {
    var celsius: String {
        return String(format: "%g°", self.rounded())
    }
}
