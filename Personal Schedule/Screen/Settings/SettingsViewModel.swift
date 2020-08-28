//
//  SettingsViewModel.swift
//  Personal Schedule
//
//  Created by Frederic Orlando on 23/08/20.
//  Copyright © 2020 Frederic Orlando. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewModel: NSObject {
    enum NibName {
        static let HomeTaskCell = "HomeTaskCell"
    }
    
    var tableView: UITableView!
    
    var day: Day! {
        didSet {
            tableView.reloadData()
        }
    }
    
    init(tableView: UITableView) {
        super.init()
        self.tableView = tableView
        tableView.isEditing = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView()
//        tableView.dragInteractionEnabled = true
        
        tableView.register(UINib(nibName: NibName.HomeTaskCell, bundle: nil), forCellReuseIdentifier: NibName.HomeTaskCell)
    }
}

extension SettingsViewModel: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if day == nil {
            return 0
        }
        return day.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NibName.HomeTaskCell) as! HomeTaskCell
        
        cell.task = day.tasks[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return day.date
    }
    
    // Drag to reorder
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let taskToMove = day.tasks[sourceIndexPath.row]
        
        day.tasks.remove(at: sourceIndexPath.row)
        day.tasks.insert(taskToMove, at: destinationIndexPath.row)
        
        Defaults.saveData(updatedTasks: day.tasks)
    }
}
