//
//  Extensions.swift
//  Personal Schedule
//
//  Created by Frederic Orlando on 21/08/20.
//  Copyright © 2020 Frederic Orlando. All rights reserved.
//

import Foundation

extension Date {
    static func localDate() -> String {
        
        let nowUTC = Date()
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC) else {return ""}
        print(localDate)
        return UtilsDate.toString(date: localDate)
    }
}

extension String {
    var prettyPrinted: NSString { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self.data(using: .utf8)!, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return "" }

        return prettyPrintedString
    }
}

extension Array where Element: NSCopying {
    func copy() -> [Element] {
        return self.map {$0.copy() as! Element}
    }
}
