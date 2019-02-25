//
//  LocationCoreData.swift
//  Weather
//
//  Created by minh duc on 2/23/19.
//  Copyright © 2019 minhduc. All rights reserved.
//
//

import CoreData

final class LocationCoreData: NSManagedObject {
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    @NSManaged var placeId: String
    
    @nonobjc func fetchRequest() -> NSFetchRequest<LocationCoreData> {
        return NSFetchRequest<LocationCoreData>(entityName: "Location")
    }
}
