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
    
    var formated: String {
        return String(format: "%g", self.rounded())
    }
    
    var hPa: String {
        return self.formated + " mb"
    }
    
    var percent: String {
        return self.formated + "%"
    }
    
    var km: String {
        return self.formated + " km"
    }
    
    var ms: String {
        return self.formated + " m/s"
    }
}
