//
//  CoordinateRequest.swift
//  Weather
//
//  Created by minh duc on 2/21/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

final class CoondinateRequest: BaseRequest {
    init(placeId: String) {
        let parameters = ["placeid": placeId,
                          "fields": "geometry",
                          "key": APIKey.googleKey]
        super.init(url: URLs.currentAutoComplete, httpMethod: .get, body: parameters)
    }
}
