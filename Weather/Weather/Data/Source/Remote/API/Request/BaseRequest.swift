//
//  BaseRequest.swift
//  Weather
//
//  Created by minh duc on 2/18/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import Alamofire

class BaseRequest: NSObject {
    var url = ""
    var httpMethod = Alamofire.HTTPMethod.get //default
    var body: [String: Any]?
    
    init(url: String) {
        super.init()
        self.url = url
    }
    
    init(url: String, httpMethod: Alamofire.HTTPMethod) {
        super.init()
        self.url = url
        self.httpMethod = httpMethod
    }
    
    init(url: String, httpMethod: Alamofire.HTTPMethod, body: [String: Any]) {
        super.init()
        self.url = url
        self.httpMethod = httpMethod
        self.body = body
    }
    
    var encode: ParameterEncoding {
        switch httpMethod {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
}
