//
//  Coordinate.swift
//  Weather
//
//  Created by minh duc on 2/21/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import ObjectMapper

struct Coordinate: Mappable {
    var lat: Double = 0
    var lng: Double = 0
    
    init() { }
    
    init(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
    }
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        lat <- map["location.lat"]
        lng <- map["location.lng"]
    }
}
