//
//  CityBackgrounds.swift
//  Weather
//
//  Created by minh duc on 2/28/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit

enum CityBackgrounds {
    case thunderstormWithRain
    case thunderstormWithDrizzle
    case drizzle
    case lightRain
    case showerRain
    case snow
    case sleet
    case snowShower
    case mist
    case clearSky
    case unexpected
    
    init(_ code: Int) {
        switch code {
        case 200...202:
            self = .thunderstormWithRain
        case 230...233:
            self = .thunderstormWithDrizzle
        case 300...302:
            self = .drizzle
        case 500...520:
            self = .lightRain
        case 521...522:
            self = .showerRain
        case 600...610:
            self = .snow
        case 611...612:
            self = .sleet
        case 621...623:
            self = .snowShower
        case 700...751:
            self = .mist
        case 800...803:
            self = .clearSky
        default:
            self = .unexpected
        }
    }
    
    var backgroundImage: UIImage? {
        switch self {
        case .thunderstormWithRain:
            return UIImage(named: "200-202")
        case .thunderstormWithDrizzle:
            return UIImage(named: "230-233")
        case .drizzle:
            return UIImage(named: "300-302")
        case .lightRain:
            return UIImage(named: "500-520")
        case .showerRain:
            return UIImage(named: "521-522")
        case .snow:
            return UIImage(named: "600-610")
        case .sleet:
            return UIImage(named: "611-612")
        case .snowShower:
            return UIImage(named: "621-623")
        case .mist:
            return UIImage(named: "700-751")
        case .clearSky:
            return UIImage(named: "800-803")
        default:
            return UIImage(named: "900")
        }
    }
}
