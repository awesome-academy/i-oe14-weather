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
            return CGSize(width: Constant.sizeDaily, height: Constant.sizeDaily)
        case .hourly:
            return CGSize(width: Constant.widthHourly, height: Constant.sizeDaily)
        case .forecastday:
            return CGSize(width: Constant.widthForecast, height: Constant.heightForecast)
        case .uv:
            return .zero
        case .humidity:
            return .zero
        default:
            return .zero
        }
    }
}

private extension ForecastCategory {
    struct Constant {
        static let sizeDaily: CGFloat = 120
        static let widthHourly: CGFloat = 50
        static let heightForecast: CGFloat = 290
        static let widthForecast: CGFloat = (Screen.width - 5) / 7
    }
}
