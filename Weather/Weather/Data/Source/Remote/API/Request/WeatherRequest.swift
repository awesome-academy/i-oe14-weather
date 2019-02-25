//
//  WeatherRequest.swift
//  Weather
//
//  Created by minh duc on 2/24/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

final class WeatherRequest: BaseRequest {
    init(location: Location) {
        let parameters: [String: Any] = ["lat": location.latitude,
                                         "lon": location.longitude,
                                         "key": APIKey.weatherKey]
        super.init(url: URLs.currentWeather, httpMethod: .get, body: parameters)
    }
    
    init(location: Location, hours: Int) {
        let parameters: [String: Any] = ["lat": location.latitude,
                                         "lon": location.longitude,
                                         "key": APIKey.weatherKey,
                                         "hours": hours]
        super.init(url: URLs.forecastHourly, httpMethod: .get, body: parameters)
    }
    
    init(location: Location, days: Int) {
        let parameters: [String: Any] = ["lat": location.latitude,
                                         "lon": location.longitude,
                                         "key": APIKey.weatherKey,
                                         "days": days]
        super.init(url: URLs.forecastDaily, httpMethod: .get, body: parameters)
    }
}
