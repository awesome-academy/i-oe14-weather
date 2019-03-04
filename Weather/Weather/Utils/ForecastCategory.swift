//
//  ForecastCategory.swift
//  Weather
//
//  Created by minh duc on 3/2/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit

enum ForecastCategory {
    case daily
    case hourly
    case forecastday
    case uv
    case humidity
    case unexpected
    
    var description: String {
        switch self {
        case .daily:
            return Constants.detail
        case .hourly:
            return Constants.hourly
        case .forecastday:
            return Constants.forecastday
        case .uv:
            return Constants.uvcondition
        case .humidity:
            return Constants.hudimity
        default:
            return ""
        }
    }
    
    var sizeItem: CGSize {
        switch self {
        case .daily:
            return CGSize(width: 120, height: 120)
        case .hourly:
            return CGSize.zero
        case .forecastday:
            return CGSize.zero
        case .uv:
            return CGSize.zero
        case .humidity:
            return CGSize.zero
        default:
            return CGSize.zero
        }
    }
}
