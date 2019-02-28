//
//  DataManager.swift
//  Weather
//
//  Created by minh duc on 2/24/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import Foundation
import Then

final class DataManager: NSObject {
    static let share = DataManager()
    private let localData = LocalData()
   
    override private init() {
        super.init()
    }
    
    func updateCoreData(with location: Location) {
        localData.update(data: location)
    }
    
    func deleteCoreData(with location: Location) {
        localData.delete(data: location)
    }
    
    func getLocations() -> [Location] {
        let locationData = localData.fetch(LocationCoreData.self)
        var locations = [Location]()
        locationData.forEach {
            let coordinate = Coordinate(lat: $0.latitude, lng: $0.longitude)
            locations.append(Location(placeId: $0.placeId, coordinate: coordinate))
        }
        return locations
    }
}
