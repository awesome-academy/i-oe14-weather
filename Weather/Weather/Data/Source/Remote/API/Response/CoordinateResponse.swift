//
//  CoordinateResponse.swift
//  Weather
//
//  Created by minh duc on 2/21/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import ObjectMapper

struct CoordinateResponse: Mappable {
    var status = ""
    var error_message = ""
    var coordinate: Coordinate?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        status <- map["status"]
        error_message <- map["error_message"]
        coordinate <- map["result.geometry"]
    }
}
