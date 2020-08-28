//
//  Day.swift
//  Personal Schedule
//
//  Created by Frederic Orlando on 19/08/20.
//  Copyright © 2020 Frederic Orlando. All rights reserved.
//

import Foundation

class  Day: Codable {
    var date: String!
    var tasks: [Task]!
    
    private enum CodingKeys: String, CodingKey {
        case date = "date"
        case tasks = "tasks"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        date = try container.decode(String.self, forKey: .date)
        tasks = try container.decode([Task].self, forKey: .tasks)
    }
    
    init() {
        self.date = UtilsDate.toString(date: Date())
        self.tasks = []
    }
}
