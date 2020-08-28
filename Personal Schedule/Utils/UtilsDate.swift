//
//  UtilsDate.swift
//  Personal Schedule
//
//  Created by Frederic Orlando on 21/08/20.
//  Copyright © 2020 Frederic Orlando. All rights reserved.
//

import Foundation

class UtilsDate {
    enum DateFormat {
        static let defaults = "E, dd MMM yyyy"
        static let time = "HH.mm"
    }
    
    class func toString(date: Date) -> String {
        let df = DateFormatter()
        df.dateFormat = DateFormat.defaults
        
        return df.string(from: date)
    }
    
    class func toString(time: Date) -> String {
        let df = DateFormatter()
        df.dateFormat = DateFormat.time
        
        return df.string(from: time)
    }
    
    class func toTime(sTime: String) -> Date {
        let df = DateFormatter()
        df.dateFormat = DateFormat.time
        
        return df.date(from: sTime)!
    }
    
    class func getDifference(from fromDate: Date, to toDate: Date) -> String {
        let delta = Int(toDate.timeIntervalSince(fromDate))
        var difference = ""
        
        let hour = delta / 3600
        let minute = delta % 3600 / 60
        
        if hour != 0 {
            difference += "\(hour) hour"
            difference += hour > 1 ? "s" : ""
            difference += minute != 0 ? " " : ""
        }
        
        if minute != 0 {
            difference += "\(minute) minute"
            difference += minute > 1 ? "s" : ""
        }
        
        return difference
    }
    
    class func roundedByFiveMinutes(time original: Date) -> String {
        let rounded = Date(timeIntervalSince1970: (original.timeIntervalSince1970 / 300.0).rounded(.towardZero) * 300.0)
        
        return toString(time: rounded)
    }
}
