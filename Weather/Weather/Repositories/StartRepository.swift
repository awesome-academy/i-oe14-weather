//
//  StartRepository.swift
//  Weather
//
//  Created by minh duc on 2/24/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import Foundation

final class StartRepository: NSObject {
    private let api = APIService.share
    
    override init() {
        super.init()
    }
    
    func fetchDataWeather(from location: Location, completion: @escaping (BaseResult<WeatherResponse>) -> Void) {
        let requestWeather = WeatherRequest(location: location)
        api.request(input: requestWeather) { (response: WeatherResponse?, error) in
            guard let response = response else {
                return completion(.failed(error: .networkError))
            }
            completion(.success(response))
        }
    }
}
