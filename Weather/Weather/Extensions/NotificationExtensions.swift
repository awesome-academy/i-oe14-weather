//
//  NotificationExtensions.swift
//  Weather
//
//  Created by minh duc on 2/27/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import Foundation

extension NSNotification.Name {
    static let deleteItemAtIndexPath = NSNotification.Name.init("deleteItemAtIndexPath")
    static let weatherDataDidChange = NSNotification.Name.init("weatherDataDidChange")
}
