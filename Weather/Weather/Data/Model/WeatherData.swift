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
                conditions.sunset.am(conditions.timezone),
                conditions.sunrise.pm(conditions.timezone)]
    }
    
    var hasData: Bool {
        return dailyWeather.count > 0 && hourlyWeather.count > 0 && forecastdayWeather.count > 0
    }
    
    override init() {
        super.init()
    }
}
