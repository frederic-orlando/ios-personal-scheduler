//
//  Task.swift
//  Personal Schedule
//
//  Created by Frederic Orlando on 19/08/20.
//  Copyright © 2020 Frederic Orlando. All rights reserved.
//

import Foundation

class Task: Codable, NSCopying {
    var name: String!
    var startTime: String?
    var endTime: String?
    var duration: String!
    var isDone: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case startTime = "startTime"
        case endTime = "endTime"
        case duration = "duration"
        case isDone = "isDone"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        startTime = try? container.decode(String.self, forKey: .startTime)
        endTime = try? container.decode(String.self, forKey: .endTime)
        duration = try container.decode(String.self, forKey: .duration)
        isDone = try container.decode(Bool.self, forKey: .isDone)
    }
    
    init(name: String, startTime: String?, endTime: String?, duration: String!) {
        self.name = name
        self.startTime = startTime
        self.endTime = endTime
        self.duration = duration
    }
    
    func reset() {
        isDone = false
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Task(name: name, startTime: startTime, endTime: endTime, duration: duration)
    }
}
