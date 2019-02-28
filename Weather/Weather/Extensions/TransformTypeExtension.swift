//
//  TransformTypeExtension.swift
//  Weather
//
//  Created by minh duc on 2/28/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import ObjectMapper

struct IntTransform: TransformType {
    typealias Object = Int
    typealias JSON = String
 
    func transformFromJSON(_ value: Any?) -> Int? {
        if let value = value as? String {
            return Int(value)
        }
        return value as? Int ?? nil
    }
    
    func transformToJSON(_ value: Int?) -> String? {
        if let intValue = value {
            return "\(intValue)"
        }
        return ""
    }
}
