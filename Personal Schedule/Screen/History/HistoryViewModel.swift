//
//  HistoryViewModel.swift
//  Personal Schedule
//
//  Created by Frederic Orlando on 21/08/20.
//  Copyright © 2020 Frederic Orlando. All rights reserved.
//

import Foundation
import UIKit

class HistoryViewModel: NSObject {
    var history: [Day]!

    enum NibName {
        static let HomeTaskCell = "HomeTaskCell"
    }
    
    var tableView: UITableView!
    
    init(tableView: UITableView) {
        super.init()
        self.tableView = tableView
        
        history = Defaults.getHistory()
        
        initTable()
    }
    
    func initTable() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: NibName.HomeTaskCell, bundle: nil), forCellReuseIdentifier: NibName.HomeTaskCell)
    }
}

extension HistoryViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history[section].tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NibName.HomeTaskCell) as! HomeTaskCell
        
        let task = history[indexPath.section].tasks[indexPath.row]
        
        cell.task = task
        cell.accessoryType = task.isDone ? .checkmark : .none
        
        print("\(history[indexPath.section].date) : Task \(task.name) is Done : \(task.isDone)")
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return history.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return history[section].date
    }
}
