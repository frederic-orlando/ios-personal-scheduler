//
//  HomeTaskCell.swift
//  Personal Schedule
//
//  Created by Frederic Orlando on 19/08/20.
//  Copyright © 2020 Frederic Orlando. All rights reserved.
//

import UIKit

class HomeTaskCell: UITableViewCell {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    
    var task: Task! {
        didSet {
            nameLbl.text = task.name
            
            let startTime = task.startTime
            let endTime = task.endTime
            let duration = task.duration!
            
            if startTime != nil {
                timeLbl.text = "\(startTime!) - \(endTime!)"
                durationLbl.text = "(\(duration))"
            }
            else {
                durationLbl.text = duration
            }
            
            timeLbl.isHidden = startTime == nil
            
            accessoryType = task.isDone ? .checkmark : .none
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
