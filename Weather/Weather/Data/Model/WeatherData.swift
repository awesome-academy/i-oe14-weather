//
//  WeatherData.swift
//  Weather
//
//  Created by minh duc on 2/26/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import Foundation

final class WeatherData: NSObject {
    var location = Location()
    var dailyWeather = [ForecastWeather]()
    var hourlyWeather = [ForecastWeather]()
    var forecastdayWeather = [ForecastWeather]()
    
    var conditions: [String] {
        guard let conditions = dailyWeather.first else {
            return []
        }
        return [Double(conditions.humidity).percent,
                conditions.uv.formated,
                conditions.visibility.km,
                conditions.windspeed.ms,
                conditions.pressure.hPa,
                conditions.sunset.pm(conditions.timezone),
                conditions.sunrise.am(conditions.timezone)]
    }
    
    var condition14days: [[String]] {
        var conditions = [[String]]()
        forecastdayWeather.forEach {
            let condition = [Double($0.humidity).percent,
                             $0.uv.formated,
                             $0.visibility.km,
                             $0.windspeed.ms,
                             $0.pressure.hPa]
            conditions.append(condition)
        }
        return conditions
    }
    
    var temperature: (min: Double, max: Double) {
        let max = forecastdayWeather.max {
            $0.maxTemperature < $1.maxTemperature
        }
        let min = forecastdayWeather.max {
            $0.minTemperature < $1.minTemperature
        }
        return (min?.minTemperature ?? 0, max?.maxTemperature ?? 0)
    }
    
    var hasData: Bool {
        return dailyWeather.count > 0 && hourlyWeather.count > 0 && forecastdayWeather.count > 0
    }
    
    override init() {
        super.init()
    }
}
