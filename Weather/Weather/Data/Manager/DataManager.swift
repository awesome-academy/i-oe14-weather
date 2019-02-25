//
//  DataManager.swift
//  Weather
//
//  Created by minh duc on 2/24/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import Foundation

final class DataManager: NSObject {
    static let share = DataManager()
    private let localData = LocalData()
    
    override init() {
        super.init()
    }
    
    func updateCoreData(with request: Location) {
        localData.update(with: request)
    }
}
