//
//  WeatherData.swift
//  Weather
//
//  Created by minh duc on 2/26/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import Foundation

final class WeatherData: NSObject {
    var dailyWeather = ForecastWeather()
    var hourlyWeather = [ForecastWeather]()
    var forecastdayWeather = [ForecastWeather]()
    
    override init() {
        super.init()
    }
}
