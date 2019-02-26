//
//  WeatherColor.swift
//  Weather
//
//  Created by minh duc on 2/25/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit

enum WeatherColor {
    case sunny, snow, thunder, wind, rain, cloudy, other
    
    init(code: Int) {
        switch code {
        case 200...202, 500...522, 621...623:
            self = .rain
        case 230...233:
            self = .thunder
        case 300...302, 601...610:
            self = .snow
        case 800...804:
            self = .sunny
        case 700...751:
            self = .cloudy
        case 611, 612:
            self = .wind
        default:
            self = .other
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .sunny:
            return UIColor.sunny
        case .snow:
            return UIColor.snow
        case .thunder:
            return UIColor.thunder
        case .wind:
            return UIColor.wind
        case .rain:
            return UIColor.rain
        case .cloudy:
            return UIColor.cloudy
        default:
            return UIColor.other
        }
    }
}
