//
//  HomeViewModel.swift
//  Personal Schedule
//
//  Created by Frederic Orlando on 19/08/20.
//  Copyright © 2020 Frederic Orlando. All rights reserved.
//

import Foundation
import UIKit

protocol HomeTableDelegate {
    func editTask(index: Int)
}

class HomeViewModel: NSObject {
    var tableView : UITableView!
    var vc : HomeViewController!
    var delegate: HomeTableDelegate!
    
    var day : Day! {
        didSet {
            tableView.reloadData()
        }
    }
    
    enum NibName {
        static let HomeTaskCell = "HomeTaskCell"
        static let AddButtonCell = "AddButtonCell"
    }
    
    init(tableView: UITableView, vc: HomeViewController) {
        super.init()
        self.tableView = tableView
        self.vc = vc
        self.delegate = vc as HomeTableDelegate
        
        initTable()
    }
    
    func initTable() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView()
        
        tableView.register(UINib(nibName: NibName.HomeTaskCell, bundle: nil), forCellReuseIdentifier: NibName.HomeTaskCell)
        tableView.register(UINib(nibName: NibName.AddButtonCell, bundle: nil), forCellReuseIdentifier: NibName.AddButtonCell)
        
        // Add quick action
//        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureRecognized(longPress:)))
//        self.tableView.addGestureRecognizer(longPress)
    }
    
    @objc func longPressGestureRecognized(longPress: UILongPressGestureRecognizer) {
        let state = longPress.state
        let location = longPress.location(in: self.tableView)
        guard let indexPath = self.tableView.indexPathForRow(at: location) else {
            return
        }
        
        switch state {
        case .began:
            let alert = UIAlertController(title: "Quick Notes", message: nil, preferredStyle: .actionSheet)

            alert.addAction(UIAlertAction(title: "Time: Earlier", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Time: Later", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Different Duration", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

            vc.present(alert, animated: true)
            break
        default:
            break
        }
    }
}

extension HomeViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if day == nil {
            return 0
        }
        else {
            return day.tasks.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NibName.HomeTaskCell) as! HomeTaskCell
        cell.task = day.tasks[indexPath.row]
        
        return cell

    }
    
//     Swipe actions
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, sourceView, completionHandler) in
            self.delegate.editTask(index: indexPath.row)
            completionHandler(true)
        }


        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            self.day.tasks.remove(at: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            
            Defaults.saveData(updatedTasks: self.day.tasks)
            
            completionHandler(true)
        }
        let swipeAction = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        swipeAction.performsFirstActionWithFullSwipe = false
        return swipeAction
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? HomeTaskCell {
            let task = day.tasks[indexPath.row]
            task.isDone = !task.isDone
            
            cell.accessoryType = task.isDone ? .checkmark : .none

            Defaults.saveData(updatedTasks: day.tasks)
        }
    }
}
