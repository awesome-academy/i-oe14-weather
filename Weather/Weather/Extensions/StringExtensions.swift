//
//  StringExtensions.swift
//  Weather
//
//  Created by minh duc on 2/20/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import Foundation

extension String {
    var ascii: String {
        return self.folding(options: .diacriticInsensitive, locale: .current)
    }
    
    func am(_ timeZone: String) -> String {
        return convert(self, format: (.HHmm, .hhmm), timeZone: timeZone) + " AM"
    }
    
    func pm(_ timeZone: String) -> String {
        return convert(self, format: (.HHmm, .hhmm), timeZone: timeZone) + " PM"
    }
    
    func ddMMyyyy(_ timeZone: String) -> String {
        return convert(self, format: (.yyyyMMddHH, .ddMMyyyy), timeZone: timeZone)
    }
    
    func hh(_ timeZone: String) -> String {
        return convert(self, format: (.yyyyMMddHH, .HH), timeZone: timeZone) + "h"
    }
    
    func dayOfWeek(_ timeZone: String) -> String {
        return convert(self, format: (.yyyyMMdd, .EEE), timeZone: timeZone)
    }
    
    func fullDayOfWeek(_ timeZone: String) -> String {
        return convert(self, format: (.yyyyMMdd, .EEEddMMyyyy), timeZone: timeZone)
    }
    
    private func convert(_ date: String, format: (in: DateFormat, out: DateFormat), timeZone: String) -> String {
        let inFormatter = DateFormatter()
        inFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        inFormatter.dateFormat = format.in.rawValue
        
        let outFormatter = DateFormatter()
        outFormatter.timeZone = TimeZone(identifier: timeZone)
        outFormatter.dateFormat = format.out.rawValue
        
        let date = inFormatter.date(from: date) ?? Date()
        return outFormatter.string(from: date)
    }
}
