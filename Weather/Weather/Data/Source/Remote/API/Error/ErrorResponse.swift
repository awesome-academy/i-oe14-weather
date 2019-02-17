//
//  ErrorResponse.swift
//  Weather
//
//  Created by minh duc on 2/18/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import ObjectMapper

struct ErrorResponse: Mappable {
    var weatherError = ""

    init?(map: Map) {
        guard let _ = map.JSON["error"] else {
            return nil
        }
    }
    
    mutating func mapping(map: Map) {
        weatherError <- map["error"]
    }
}
