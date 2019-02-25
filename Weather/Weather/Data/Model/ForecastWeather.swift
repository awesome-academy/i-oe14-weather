//
//  ForecastWeather.swift
//  Weather
//
//  Created by minh duc on 2/24/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import ObjectMapper

final class ForecastWeather: Mappable {
    var rh = 0
    var clouds = 0
    var uv: Double = 0
    var vis: Double = 0
    var temp: Double = 0
    var pres: Double = 0
    var winspeed: Double = 0
    var sunset = ""
    var sunrise = ""
    var city = ""
    var weather = CurrentWeather()
    
    init() { }
    
    init?(map: Map) { }
    
    func mapping(map: Map) {
        rh <- map["rh"]
        clouds <- map["clouds"]
        uv <- map["uv"]
        vis <- map["vis"]
        temp <- map["temp"]
        pres <- map["pres"]
        winspeed <- map["wind_spd"]
        sunset <- map["sunset"]
        sunrise <- map["sunrise"]
        city <- map["city_name"]
        weather <- map["weather"]
    }
}
