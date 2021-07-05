//
//  ListCityRepository.swift
//  Weather
//
//  Created by minh duc on 2/24/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import Foundation

final class ListCityRepository: NSObject {
    private let api = APIService.shared
    private let database = Database.shared
    private let operationQueue = OperationQueue().then {
        $0.maxConcurrentOperationCount = 1
        $0.qualityOfService = .utility
    }
    
    override init() {
        super.init()
    }
    
    func fetchData(locations: [Location], completion: @escaping (BaseResult<WeatherData>) -> Void) {
        locations.forEach {
            let operation = blockOperation(with: $0) { (data, error) in
                guard let error = error else {
                    return completion(.success(data))
                }
                completion(.failed(error: error))
            }
            operationQueue.addOperation(operation)
        }
    }
    
    func fetchData(location: Location, completion: @escaping (BaseResult<WeatherData>) -> Void) {
        let operation = blockOperation(with: location) { (data, error) in
            guard let error = error else {
                return completion(.success(data))
            }
            completion(.failed(error: error))
        }
        operationQueue.addOperation(operation)
    }
    
    private func blockOperation(with location: Location, completion: @escaping (WeatherData, BaseError?) -> Void) -> BlockOperation {
        return BlockOperation { [weak self] in
            guard let self = self else { return }
            let group = DispatchGroup()
            let weatherData = WeatherData().then {
                $0.location = location
            }
            var baseError: BaseError?

            let request = WeatherRequest(location: location)
            self.request(request, group: group) { (data, error) in
                guard let data = data else {
                    return baseError = error
                }
                weatherData.dailyWeather = data
            }
            
            let requestH = WeatherRequest(location: location, hours: Constant.maxHours)
            self.request(requestH, group: group) { (data, error) in
                guard let data = data else {
                    return baseError = error
                }
                weatherData.hourlyWeather = data
            }
            
            let requestD = WeatherRequest(location: location, days: Constant.maxDays)
            self.request(requestD, group: group) { (data, error) in
                guard let data = data else {
                    return baseError = error
                }
                weatherData.forecastdayWeather = data
            }
            completion(weatherData, baseError)
        }
    }
    
    private func request(_ request: WeatherRequest, group: DispatchGroup, completion: @escaping ([ForecastWeather]?, BaseError?) -> Void) {
        group.enter()
        api.request(input: request) { (response: WeatherResponse?, error) in
            if let error = error {
                completion(nil, error)
            } else if let data = response?.forecastWeathers {
                completion(data, nil)
            }
            group.leave()
        }
        group.wait()
    }
}

// MARK: - ListCityRepository
private extension ListCityRepository {
    struct Constant {
        static let maxDays = 14
        static let maxHours = 16
    }
}
