//
//  URLs.swift
//  Weather
//
//  Created by minh duc on 2/18/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

struct URLs {
    private static let hostGoogle = "https://maps.googleapis.com"
    private static let hostAPI = "https://api.weatherbit.io"
    static let placeAutoComplete = hostGoogle + "/maps/api/place/autocomplete/json"
    static let currentAutoComplete = hostGoogle + "/maps/api/place/details/json"
    static let currentWeather = hostAPI + "/v2.0/current"
    static let forecastDaily = hostAPI + "/v2.0/forecast/daily"
    static let forecastHourly = hostAPI + "/v2.0/forecast/hourly"
}
