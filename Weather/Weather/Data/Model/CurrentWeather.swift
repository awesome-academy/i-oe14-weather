//
//  CurrentWeather.swift
//  Weather
//
//  Created by minh duc on 2/24/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import ObjectMapper

final class CurrentWeather: Mappable {
    var icon = ""
    var code = 0
    var description = ""
    
    init() { }
    
    init?(map: Map) { }
    
    func mapping(map: Map) {
        icon <- map["icon"]
        code <- (map["code"], IntTransform())
        description <- map["description"]
    }
}
