//
//  LocalData.swift
//  Weather
//
//  Created by minh duc on 2/23/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import Foundation
import CoreData

final class LocalData: NSObject {
    private struct Constant {
        static let weather = "Weather"
        static let entity = "Location"
    }
    
    override init() {
        super.init()
    }

    private let persistentContainer = NSPersistentContainer(name: Constant.weather).then {
        $0.loadPersistentStores { (_, error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    private lazy var context = persistentContainer.viewContext
    
    private func save() {
        do {
            if context.hasChanges {
                try context.save()
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func update(data location: Location) {
        fetch(LocationCoreData.self).forEach {
            // update location with current place id
            if $0.placeId == location.placeId {
                $0.do {
                    $0.placeId = location.placeId
                    $0.latitude = location.latitude
                    $0.longitude = location.longitude
                }
            }
        }
        
        // add new location
        if !context.hasChanges {
            let _ = LocationCoreData(context: context).then {
                $0.placeId = location.placeId
                $0.latitude = location.latitude
                $0.longitude = location.longitude
            }
        }
        save()
    }
    
    @discardableResult
    func fetch<T: NSManagedObject>(_ type: T.Type) -> [T] {
        do {
            guard
                let datas = try context.fetch(T.fetchRequest()) as? [T]
            else {
                return [T]()
            }
            return datas
        } catch let error {
            print(error.localizedDescription)
        }
        return [T]()
    }
}
