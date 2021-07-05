//
//  ForecastWeather.swift
//  Weather
//
//  Created by minh duc on 2/24/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import ObjectMapper

final class ForecastWeather: Mappable {
    var humidity = 0
    var clouds = 0
    var uv: Double = 0
    var visibility: Double = 0
    var temperature: Double = 0
    var pressure: Double = 0
    var windspeed: Double = 0
    var sunset = ""
    var sunrise = ""
    var cityName = ""
    var datetime = ""
    var timezone = ""
    var weather = CurrentWeather()
    var maxTemp: Double = 0
    var minTemp: Double = 0
    
    init() { }
    
    init?(map: Map) { }
    
    func mapping(map: Map) {
        humidity <- map["rh"]
        clouds <- map["clouds"]
        uv <- map["uv"]
        visibility <- map["vis"]
        temperature <- map["temp"]
        pressure <- map["pres"]
        windspeed <- map["wind_spd"]
        sunset <- map["sunset"]
        sunrise <- map["sunrise"]
        cityName <- map["city_name"]
        weather <- map["weather"]
        datetime <- map["datetime"]
        timezone <- map["timezone"]
        maxTemp <- map["max_temp"]
        minTemp <- map["min_temp"]
        maxTemp = maxTemp.rounded()
        minTemp = minTemp.rounded()
    }
}
