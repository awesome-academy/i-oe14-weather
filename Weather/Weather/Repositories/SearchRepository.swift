//
//  SearchRepository.swift
//  Weather
//
//  Created by minh duc on 2/19/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import Foundation

class SearchRepository: NSObject {
    private let api = APIService.share
    
    override init() {
        super.init()
    }
    
    func searchLocation(keyword: String, completion: @escaping (BaseResult<SearchResponse>) -> Void ) {
        let searchRequest = SearchRequest(keyword: keyword)
        api.request(input: searchRequest) { (object: SearchResponse?, error) in
            guard let _object = object else {
                return completion(.failed(error: error))
            }
            switch _object.status {
            case Constants.ok:
                completion(.success(_object))
            default:
                completion(.failed(error: .googleError(_object.status)))
            }
        }
    }
}
