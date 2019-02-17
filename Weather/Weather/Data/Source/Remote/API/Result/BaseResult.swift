//
//  BaseResult.swift
//  Weather
//
//  Created by minh duc on 2/18/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import ObjectMapper

enum BaseResult<T: Mappable> {
    case success(T?)
    case failed(error: BaseError?)
}
