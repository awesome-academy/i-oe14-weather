//
//  SearchRepository.swift
//  Weather
//
//  Created by minh duc on 2/19/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import Foundation

final class SearchRepository: NSObject {
    private let api = APIService.share
    
    override init() {
        super.init()
    }
    
    func searchLocation(keyword: String, completion: @escaping (BaseResult<SearchResponse>) -> Void) {
        let searchRequest = SearchRequest(keyword: keyword)
        api.request(input: searchRequest) { (response: SearchResponse?, error) in
            guard let response = response else {
                return completion(.failed(error: error))
            }
            switch response.status {
            case Constants.ok:
                completion(.success(response))
            default:
                completion(.failed(error: .googleError(response.status)))
            }
        }
    }
    
    func searchCoordinate(of placeId: String, completion: @escaping (BaseResult<CoordinateResponse>) -> Void) {
        let coordinateRequest = CoondinateRequest(placeId: placeId)
        api.request(input: coordinateRequest) { (response: CoordinateResponse?, error) in
            guard let response = response else {
                return completion(.failed(error: error))
            }
            switch response.status {
            case Constants.ok:
                completion(.success(response))
            default:
                completion(.failed(error: .googleError(Constants.blank)))
            }
        }
    }
}
