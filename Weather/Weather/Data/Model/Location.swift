//
//  Location.swift
//  Weather
//
//  Created by minh duc on 2/24/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import Then

struct Location: Then {
    var latitude: Double = 0
    var longitude: Double = 0
    var placeId = ""
    
    init(placeId: String, coordinate: Coordinate) {
        self.placeId = placeId
        self.latitude = coordinate.lat
        self.longitude = coordinate.lng
    }
    
    init() { }
}
