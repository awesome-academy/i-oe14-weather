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
    static let share = LocalData()
    
    override init() {
        super.init()
    }
    
    private let persistentContainer = NSPersistentContainer(name: "Weather").then {
        $0.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                print(error.localizedDescription)
            }
        })
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
    
    func update(with location: Location) {
        fetch().forEach {
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
    func fetch() -> [LocationCoreData] {
        let fetchRequest = NSFetchRequest<LocationCoreData>(entityName: "Location")
        do {
            let location = try context.fetch(fetchRequest)
            return location
        } catch let error {
            print(error.localizedDescription)
        }
        return [LocationCoreData]()
    }
}
