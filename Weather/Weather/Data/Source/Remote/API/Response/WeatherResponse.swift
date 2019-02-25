//
//  WeatherResponse.swift
//  Weather
//
//  Created by minh duc on 2/24/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import ObjectMapper

final class WeatherResponse: Mappable {
    var forecastWeathers = [ForecastWeather]()
    
    init?(map: Map) { }
    
    func mapping(map: Map) {
        forecastWeathers <- map["data"]
    }
}
