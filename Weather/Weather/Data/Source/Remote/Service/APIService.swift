//
//  APIService.swift
//  Weather
//
//  Created by minh duc on 2/15/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import ObjectMapper
import Alamofire

class APIService {
    static let shared = APIService()
    
    private lazy var sessionManager: Alamofire.SessionManager = {
        let config = URLSessionConfiguration.ephemeral
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 30
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        return Alamofire.SessionManager(configuration: config)
    }()
    
    func request<T: Mappable>(input: BaseRequest, completion: @escaping(_ object: T?, _ error: BaseError?) -> Void) {
        
        print("\n------------REQUEST INPUT")
        print("link: %@", input.url)
        print("body: %@", input.body ?? "No Body")
        print("------------ END REQUEST INPUT\n")
        
        sessionManager.request(input.url, method: input.httpMethod, parameters: input.body, encoding: input.encode)
            .validate(statusCode: 200..<299)
            .responseJSON(queue: .global(qos: .background), options: .mutableContainers) { response in
                guard let statusCode = response.response?.statusCode else {
                    return completion(nil, .unexpectedError(response.error))
                }
                // handle data
                switch response.result {
                case .success(let data):
                    guard let error = Mapper<ErrorResponse>().map(JSONObject: data) else {
                        return completion(Mapper<T>().map(JSONObject: data), nil)
                    }
                    return completion(nil, .apiFailure(error: error))
                case .failure(let error):
                    switch statusCode {
                    case 300...511:
                        completion(nil, .httpError(code: statusCode))
                    default:
                        completion(nil, .unexpectedError(error))
                    }
                }//End
            }
    }
}
