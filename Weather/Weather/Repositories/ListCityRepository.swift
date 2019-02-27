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
        $0.maxConcurrentOperationCount = 2
        $0.qualityOfService = .utility
    }
    
    override init() {
        super.init()
    }
    
    func fetchData(weatherDatas: [WeatherData], completion: @escaping((IndexPath) -> Void)) {
        let locations = dataManager.getLocations()
        
        for i in 0..<weatherDatas.count {
            let weatherOperation = WeatherDataOperation(weatherDatas[i], location: locations[i])
            weatherOperation.completionBlock = {
                completion(IndexPath(row: i, section: 0))
            }
            operationQueue.addOperation(weatherOperation)
        }
    }
}
