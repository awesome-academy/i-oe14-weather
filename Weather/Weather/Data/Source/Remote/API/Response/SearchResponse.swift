//
//  SearchResponse.swift
//  Weather
//
//  Created by minh duc on 2/18/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import ObjectMapper

struct SearchResponse: Mappable {
    var predictions = [Prediction]()
    var status = ""
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        predictions <- map["predictions"]
        status <- map["status"]
    }
}
