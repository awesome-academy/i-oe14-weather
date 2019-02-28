//
//  ListCityRepository.swift
//  Weather
//
//  Created by minh duc on 2/24/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import Foundation

final class ListCityRepository: NSObject {
    private let api = APIService.share
    private let dataManager = DataManager.share
    private let operationQueue = OperationQueue().then {
        $0.maxConcurrentOperationCount = 1
        $0.qualityOfService = .utility
    }
    
    override init() {
        super.init()
    }
    
    func fetchData(locations: [Location], completion: @escaping((WeatherData) -> Void)) {
        locations.forEach {
            let operation = blockOperation(with: $0) { weatherData in
                completion(weatherData)
            }
            operationQueue.addOperation(operation)
        }
    }
    
    func fetchData(location: Location, completion: @escaping((WeatherData) -> Void)) {
        let operation = blockOperation(with: location) { weatherData in
            completion(weatherData)
        }
        operationQueue.addOperation(operation)
    }
    
    private func blockOperation(with location: Location, completion: @escaping((WeatherData) -> Void)) -> BlockOperation {
        return BlockOperation {
            let dispatchGroup = DispatchGroup()
            let weatherData = WeatherData().then {
                $0.location = location
            }
            let serialQueue = DispatchQueue(label: location.placeId, qos: .utility)
            
            // start current request
            serialQueue.sync { [weak self] in
                guard let self = self else { return }
                dispatchGroup.enter()
                
                let requestCurrentday = WeatherRequest(location: location)
                self.api.request(input: requestCurrentday) { (response: WeatherResponse?, error) in
                    guard let dailyData = response?.forecastWeathers else {
                        return dispatchGroup.leave()
                    }
                    weatherData.dailyWeather = dailyData
                    dispatchGroup.leave()
                }
                dispatchGroup.wait()
            }
            
            // start hourly request
            serialQueue.sync { [weak self] in
                guard let self = self else { return }
                dispatchGroup.enter()
                
                let requestHourly = WeatherRequest(location: location, hours: Constant.maxHours)
                self.api.request(input: requestHourly) { (response: WeatherResponse?, error) in
                    guard let response = response else {
                        return dispatchGroup.leave()
                    }
                    weatherData.hourlyWeather = response.forecastWeathers
                    dispatchGroup.leave()
                }
                dispatchGroup.wait()
            }
            
            // start daily request
            serialQueue.sync { [weak self] in
                guard let self = self else { return }
                dispatchGroup.enter()
                
                let requestForecastday = WeatherRequest(location: location, days: Constant.maxDays)
                self.api.request(input: requestForecastday) { (response: WeatherResponse?, error) in
                    guard let response = response else {
                        return dispatchGroup.leave()
                    }
                    weatherData.forecastdayWeather = response.forecastWeathers
                    dispatchGroup.leave()
                }
                dispatchGroup.wait()
            }
            completion(weatherData)
        }
    }
}

// MARK: - ListCityRepository
private extension ListCityRepository {
    struct Constant {
        static let maxDays = 14
        static let maxHours = 16
        static let timeOut: DispatchTime = .now() + 3
    }
}
