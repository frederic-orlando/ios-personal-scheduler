//
//  UserDefault.swift
//  Personal Schedule
//
//  Created by Frederic Orlando on 20/08/20.
//  Copyright © 2020 Frederic Orlando. All rights reserved.
//

import Foundation

class Defaults {
    static let defaults = UserDefaults.standard
    enum Key {
        static let today = "today"
        static let history = "history"
    }
    
//    static var dummyTasks = [
//        Task(name: "Learn Balisong", time: nil, duration: "30 minutes"),
//        Task(name: "Exercise", time: "07.00 - 08.00", duration: "1 hour"),
//        Task(name: "Learn Typing", time: "10.00 - 11.00", duration: "1 hour"),
//        Task(name: "Learn Swift", time: "11.00 - 17.00", duration: "6 hours"),
//        Task(name: "Learn Cardistry", time: "17.00 - 18.00", duration: "1 hour"),
//        Task(name: "Learn Typing", time: "19.00 - 20.00", duration: "1 hour"),
//    ]
    
    class func saveData(today: Day) {
        let jsonData = try! JSONEncoder().encode(today)
        let json = String(data: jsonData, encoding: .utf8)!
        
        saveData(json, key: Key.today)
    }
    
    class func saveData(today: Day, lastDay: Day) {
        saveData(today: today)
        saveData(lastDay: lastDay)
    }
    
    class func saveData(updatedTasks: [Task]) {
        let today = getCurrentDay()
        today.tasks = updatedTasks
        
        saveData(today: today)
    }
    
    class func saveData(lastDay: Day) {
        var updatedHistory = getHistory()
        
        updatedHistory.append(lastDay)
        
        saveData(history: updatedHistory)
    }
    
    class func saveData(history: [Day]) {
        var history = history
        if history.count > 30 {
            history.remove(at: 0)
        }
        
        let jsonData = try! JSONEncoder().encode(history)
        let json = String(data: jsonData, encoding: .utf8)!
        
        saveData(json, key: Key.history)
    }
    
    fileprivate class func saveData(_ json: String, key: String) {
        defaults.set(json, forKey: key)
    }
    
    class func getCurrentDay() -> Day {
        guard let jsonDay = defaults.string(forKey: Key.today) else {
            let day = Day()
//            day.tasks = dummyTasks
            
            saveData(today: day)
            
            return day
        }

        let day = try! JSONDecoder().decode(Day.self, from: Data(jsonDay.utf8))
        
        return day
    }
    
    class func getHistory() -> [Day] {
        guard let jsonHistory = defaults.string(forKey: Key.history) else {
            let history = [Day]()
            saveData(history: history)
            
            return history
        }

        var history = try! JSONDecoder().decode([Day].self, from: Data(jsonHistory.utf8))
        history.reverse()
        return history
    }
    
    class func clearData() {
        defaults.removeObject(forKey: Key.today)
        defaults.removeObject(forKey: Key.history)
    }
}
