//
//  ViewController.swift
//  Personal Schedule
//
//  Created by Frederic Orlando on 19/08/20.
//  Copyright © 2020 Frederic Orlando. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addBtn: UIBarButtonItem!
    
    enum Segue {
        static let showTaskForm = "ShowTaskForm"
    }
    
    var viewModel: HomeViewModel!
    var day: Day! {
        didSet {
            viewModel.day = day
        }
    }
    
    var isTableEditing : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = HomeViewModel(tableView: tableView, vc: self)
//        Defaults.clearData()
        checkDate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkDate()
    }
    
    func checkDate() {
        let lastDay = Defaults.getCurrentDay()
        
        if lastDay.date != UtilsDate.toString(date: Date()) {
            let today = Day()
            
            today.tasks = lastDay.tasks.copy()
            
            for task in today.tasks {
                task.reset()
            }
            
            Defaults.saveData(today: today, lastDay: lastDay)
            day = today
        }
        else {
            day = lastDay
        }
    }
    
    @IBAction func addTask(_ sender: Any) {
        performSegue(withIdentifier: Segue.showTaskForm, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Segue.showTaskForm:
            let vc = segue.destination as! TaskFormViewController
            vc.taskIndex = sender as? Int
            
            let back = UIBarButtonItem()
            back.title = "Cancel"
            
            navigationItem.backBarButtonItem = back
            
        default:
            break
        }
    }
}

extension HomeViewController: HomeTableDelegate {
    func editTask(index: Int) {
        performSegue(withIdentifier: Segue.showTaskForm, sender: index)
    }
}
