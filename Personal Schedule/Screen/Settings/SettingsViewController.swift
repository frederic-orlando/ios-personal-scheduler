//
//  SettingsViewController.swift
//  Personal Schedule
//
//  Created by Frederic Orlando on 23/08/20.
//  Copyright © 2020 Frederic Orlando. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: SettingsViewModel!
    var day: Day! {
        didSet {
            viewModel.day = day
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = SettingsViewModel(tableView: tableView)
        day = Defaults.getCurrentDay()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        day = Defaults.getCurrentDay()
    }
    
}
