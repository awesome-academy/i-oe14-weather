//
//  Prediction.swift
//  Weather
//
//  Created by minh duc on 2/18/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import ObjectMapper

struct Prediction: Mappable {
    var description = ""
    var placeId = ""
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        description <- map["description"]
        placeId <- map["place_id"]
    }
}
