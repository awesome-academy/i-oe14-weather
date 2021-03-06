//
//  WeatherDataOperation.swift
//  Weather
//
//  Created by minh duc on 2/26/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import Foundation

final class WeatherDataOperation: Operation {
    private let api = APIService.shared
    private var location = Location()
    private var weatherData = WeatherData()
    
    init(_ weatherData: WeatherData, location: Location) {
        self.location = location
        self.weatherData = weatherData
    }
    
    override func main() {
        if isCancelled { return }
        
        let dispatchGroup = DispatchGroup().then {
            $0.enter()
            $0.enter()
            $0.enter()
        }
        
        let requestCurrentday = WeatherRequest(location: location)
        api.request(input: requestCurrentday) { [weak self] (response: WeatherResponse?, error) in
            guard
                let _ = self,
                let response = response,
                let _ = response.forecastWeathers.first
            else {
                return dispatchGroup.leave()
            }
            dispatchGroup.leave()
        }
        
        let requestHourly = WeatherRequest(location: location, hours: Constant.maxHours)
        api.request(input: requestHourly) { [weak self] (response: WeatherResponse?, error) in
            guard let self = self, let response = response else {
                return dispatchGroup.leave()
            }
            
            self.weatherData.hourlyWeather = response.forecastWeathers
            dispatchGroup.leave()
        }
        
        let requestForecastday = WeatherRequest(location: location, days: Constant.maxDays)
        api.request(input: requestForecastday) { [weak self] (response: WeatherResponse?, error) in
            guard let self = self, let response = response else {
                return dispatchGroup.leave()
            }
            
            self.weatherData.forecastdayWeather = response.forecastWeathers
            dispatchGroup.leave()
        }
        
        let _ = dispatchGroup.wait(timeout: Constant.maxTimeout)
    }
}

// MARK: - WeatherDataOperation
private extension WeatherDataOperation {
    struct Constant {
        static let maxDays = 14
        static let maxHours = 16
        static let maxTimeout: DispatchTime = .now() + 3
    }
}
