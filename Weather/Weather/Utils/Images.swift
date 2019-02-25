//
//  Images.swift
//  Weather
//
//  Created by minh duc on 2/21/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit

enum Weather {
    case t01d, t01n // Thunderstorm with rain
    case t04d, t04n // Thunderstorm with drizzle
    case d01d, d01n, d02d, d02n, d03d, d03n // Light Drizzle, Drizzle, Heavy Drizzle
    case r01d, r01n, r02d, r02n, r03d, r03n // Light Rain, Moderate Rain, Heavy Rain
    case f01d, f01n, r04d, r04n, r05d, r05n, r06d, r06n // Freezing rain - Heavy shower rain
    case s01d, s01n, s02d, s02n, s03d, s03n // Light snow, Snow, Heavy Snow
    case s04d, s04n, s06d, s06n // Mix/rain
    
    case s05d, s05n // sleet
    case a01d, a01n // mist/fog
    case c01d, c01n // clear sky
    case c02d, c02n // few cloud
    case c03d, c03n // Scattered cloud
    case c04d // Overcast clouds
    case u00d // unknown
    
    init(_ icon: String) {
        switch icon {
        case "t01d", "t02d", "t03d":
            self = .t01d
        case "t01n", "t02n", "t03n":
            self = .t01n
        case "t04d", "t05d":
            self = .t04d
        case "t04n", "t05n":
            self = .t04n
        case "d01d":
            self = .d01d
        case "d01n":
            self = .d01n
        case "d02d":
            self = .d02d
        case "d02n":
            self = .d02n
        case "d03d":
            self = .d03d
        case "d03n":
            self = .d03n
        case "r01d":
            self = .r01d
        case "r01n":
            self = .r01n
        case "r02d":
            self = .r02d
        case "r02n":
            self = .r02n
        case "r03d":
            self = .r03d
        case "r03n":
            self = .r03n
        case "f01d":
            self = .f01d
        case "f01n":
            self = .f01n
        case "r04d":
            self = .r04d
        case "r04n":
            self = .r04n
        case "r05d":
            self = .r05d
        case "r05n":
            self = .r05n
        case "r06d":
            self = .r06d
        case "r06n":
            self = .r06n
        case "s01d":
            self = .s01d
        case "s01n":
            self = .s01n
        case "s02d":
            self = .s02d
        case "s02n":
            self = .s02n
        case "s03d":
            self = .s03d
        case "s03n":
            self = .s03n
        case "s04d":
            self = .s04d
        case "s04n":
            self = .s04n
        case "s06d":
            self = .s06d
        case "s06n":
            self = .s06n
        case "s05d":
            self = .s05d
        case "s05n":
            self = .s05n
        case "a01d", "a02d", "a03d", "a04d", "a05d", "a06d":
            self = .a01d
        case "a01n", "a02n", "a03n", "a04n", "a05n", "a06n":
            self = .a01n
        case "c01d":
            self = .c01d
        case "c01n":
            self = .c01n
        case "c02d":
            self = .c02d
        case "c02n":
            self = .c02n
        case "c03d":
            self = .c03d
        case "c03n":
            self = .c03n
        case "c04d", "c04n":
            self = .c04d
        default:
            self = .u00d
        }
    }
    
    var description: String {
        switch self {
        case .t01d, .t01n:
            return "Thunderstorm with light rain"
        case .t04d, .t04n:
            return "Thunderstorm with drizzle"
        case .d01d, .d01n:
            return "Light Drizzle"
        case .d02d, .d02n:
            return "Drizzle"
        case .d03d, .d03n:
            return "Heavy Drizzle"
        case .r01d, .r01n:
            return "Light Rain"
        case .r02d, .r02n:
            return "Moderate Rain"
        case .r03d, .r03n:
            return "Heavy Rain"
        case .f01d, .f01n:
            return "Freezing rain"
        case .r04d, .r04n:
            return "Light shower rain"
        case .r05d, .r05n:
            return "Shower rain"
        case .r06d, .r06n:
            return "Heavy shower rain"
        case .s01d, .s01n:
            return "Light Snow"
        case .s02d, .s02n:
            return "Snow"
        case .s03d, .s03n:
            return "Heavy Snow"
        case .s04d, .s04n:
            return "Mix snow/rain"
        case .s05d, .s05n:
            return "Sleet"
        case .s06d, .s06n:
            return "Flurries"
        case .a01d, .a01n:
            return "Mist/Fog"
        case .c01d, .c01n:
            return "Clear Sky"
        case .c02d, .c02n:
            return "Few clouds"
        case .c03d, .c03n:
            return "Mostly clouds"
        case .c04d:
            return "Overcast clouds"
        case .u00d:
            return "Unknown Condition"
        }
    }
    
    var smallImage: UIImage? {
        switch self {
        case .t01d:
            return UIImage(named: "storm-weather-day")
        case .t01n:
            return UIImage(named: "storm-weather-night")
        case .t04d:
            return UIImage(named: "thunder-day")
        case .t04n:
            return UIImage(named: "thunder-night")
        case .d01d, .d02d, .d03d, .r01d, .r02d, .r03d, .f01d, .r04d, .r05d, .r06d:
            return UIImage(named: "rainy-day")
        case .d01n, .d02n, .d03n, .r01n, .r02n, .r03n, .f01n, .r04n, .r05n, .r06n:
            return UIImage(named: "rainy-night")
        case .s01d, .s02d, .s03d:
            return UIImage(named: "snow-day")
        case .s01n, .s02n, .s03n:
            return UIImage(named: "snow-night")
        case .s04d, .s06d, .s05d:
            return UIImage(named: "rain-snow-day")
        case .s04n, .s06n, .s05n:
            return UIImage(named: "rain-snow-night")
        case .a01d:
            return UIImage(named: "haze-day")
        case .a01n:
            return UIImage(named: "haze-night")
        case .c01d:
            return UIImage(named: "clear-day")
        case .c01n:
            return UIImage(named: "clear-night")
        case .c02d:
            return UIImage(named: "partly-cloudy-day")
        case .c02n:
            return UIImage(named: "partly-cloudy-night")
        case .c03d:
            return UIImage(named: "mostly-cloudy-day")
        case .c03n:
            return UIImage(named: "mostly-cloudy-night")
        case .c04d:
            return UIImage(named: "cloudy-weather")
        case .u00d:
            return UIImage(named: "unknown")
        }
    }
    
    var largeImage: UIImage? {
        switch self {
        case .t01d:
            return UIImage(named: "storm-weather-day-large")
        case .t01n:
            return UIImage(named: "storm-weather-night-large")
        case .t04d:
            return UIImage(named: "thunder-day-large")
        case .t04n:
            return UIImage(named: "thunder-night-large")
        case .d01d, .d02d, .d03d, .r01d, .r02d, .r03d, .f01d, .r04d, .r05d, .r06d:
            return UIImage(named: "rainy-day-large")
        case .d01n, .d02n, .d03n, .r01n, .r02n, .r03n, .f01n, .r04n, .r05n, .r06n:
            return UIImage(named: "rainy-night-large")
        case .s01d, .s02d, .s03d:
            return UIImage(named: "snow-day-large")
        case .s01n, .s02n, .s03n:
            return UIImage(named: "snow-night-large")
        case .s04d, .s06d, .s05d:
            return UIImage(named: "rain-snow-day-large")
        case .s04n, .s06n, .s05n:
            return UIImage(named: "rain-snow-night-large")
        case .a01d:
            return UIImage(named: "haze-day-large")
        case .a01n:
            return UIImage(named: "haze-night-large")
        case .c01d:
            return UIImage(named: "clear-day-large")
        case .c01n:
            return UIImage(named: "clear-night-large")
        case .c02d:
            return UIImage(named: "partly-cloudy-day-large")
        case .c02n:
            return UIImage(named: "partly-cloudy-night-large")
        case .c03d:
            return UIImage(named: "mostly-cloudy-day-large")
        case .c03n:
            return UIImage(named: "mostly-cloudy-night-large")
        case .c04d:
            return UIImage(named: "cloudy-weather-large")
        case .u00d:
            return UIImage(named: "unknown-large")
        }
    }
}
