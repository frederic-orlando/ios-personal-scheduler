//
//  HistoryViewController.swift
//  Personal Schedule
//
//  Created by Frederic Orlando on 21/08/20.
//  Copyright © 2020 Frederic Orlando. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel : HistoryViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HistoryViewModel(tableView: tableView)
    }
}
