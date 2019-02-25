//
//  URLs.swift
//  Weather
//
//  Created by minh duc on 2/18/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

struct URLs {
    private static let hostGoogle = "https://maps.googleapis.com/maps/api/place"
    private static let hostAPI = "https://api.weatherbit.io/v2.0"
    static let placeAutoComplete = hostGoogle + "/autocomplete/json"
    static let currentAutoComplete = hostGoogle + "/details/json"
    static let currentWeather = hostAPI + "/current"
    static let forecastDaily = hostAPI + "/forecast/daily"
    static let forecastHourly = hostAPI + "/forecast/hourly"
}
