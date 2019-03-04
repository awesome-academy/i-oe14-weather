//
//  Conditions.swift
//  Weather
//
//  Created by minh duc on 3/2/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit

enum Conditions {
    case pressure
    case visibility
    case sunrise
    case sunset
    case uv
    case humidity
    case wind
    
    init(row: Int) {
        switch row {
        case 0:
            self = .humidity
        case 1:
            self = .uv
        case 2:
            self = .visibility
        case 3:
            self = .wind
        case 4:
            self = .pressure
        case 5:
            self = .sunset
        default:
            self = .sunrise
        }
    }
    
    var description: String {
        switch self {
        case .pressure:
            return Constants.pressure
        case .visibility:
            return Constants.visibility
        case .sunrise:
            return Constants.sunrise
        case .sunset:
            return Constants.sunset
        case .uv:
            return Constants.uvcondition
        case .humidity:
            return Constants.hudimity.lowercased()
        case .wind:
            return Constants.windspeed
        }
    }
    
    var image: UIImage? {
        switch self {
        case .pressure:
            return UIImage(named: "pressure")
        case .visibility:
            return UIImage(named: "visibility")
        case .sunrise:
            return UIImage(named: "sunrise")
        case .sunset:
            return UIImage(named: "sunset")
        case .uv:
            return UIImage(named: "uv")
        case .humidity:
            return UIImage(named: "humidity")
        case .wind:
            return UIImage(named: "wind")
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .pressure:
            return .pressure
        case .visibility:
            return .visibility
        case .sunrise:
            return .sunrise
        case .sunset:
            return .sunset
        case .uv:
            return .uv
        case .humidity:
            return .humidity
        case .wind:
            return .wind
        }
    }
}
