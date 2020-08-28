//
//  TaskFormViewController.swift
//  Personal Schedule
//
//  Created by Frederic Orlando on 24/08/20.
//  Copyright © 2020 Frederic Orlando. All rights reserved.
//

import UIKit

class TaskFormViewController: UITableViewController {
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var allDaySwitch: UISwitch!
    
    @IBOutlet weak var startTimeLbl: UILabel!
    @IBOutlet weak var startPickerCell: UITableViewCell!
    @IBOutlet weak var startTimePicker: UIDatePicker!
    @IBOutlet weak var endTimeLbl: UILabel!
    @IBOutlet weak var endPickerCell: UITableViewCell!
    @IBOutlet weak var endTimePicker: UIDatePicker!
    @IBOutlet weak var durationTxt: UITextField!
    
    let defaultPickerHeight: CGFloat = 100
    
    var tasks : [Task]!
    var taskIndex : Int!
    
    enum Row {
        static let allDay = IndexPath(row: 0, section: 1)
        static let startTime = IndexPath(row: 1, section: 1)
        static let startPicker = IndexPath(row: 2, section: 1)
        static let endTime = IndexPath(row: 3, section: 1)
        static let endPicker = IndexPath(row: 4, section: 1)
        static let duration = IndexPath(row: 5, section: 1)
    }
    
    var isAllDay: Bool! {
        didSet {
            allDaySwitch.setOn(isAllDay, animated: true)
            
            pickerHeight = 0
            
            disableCell(indexPath: Row.startTime)
            disableCell(indexPath: Row.endTime)
            
            durationTxt.isEnabled = isAllDay
            durationTxt.alpha = isAllDay ? 1 : 0.5
            
            tableView.reloadData()
        }
    }
    
    var pickerHeight: CGFloat! {
        didSet {
            startPickerHeight = pickerHeight
            endPickerHeight = pickerHeight
        }
    }
    
    var startPickerHeight: CGFloat!
    var endPickerHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tasks = Defaults.getCurrentDay().tasks
        
        initField()
//        let imageView = UIImageView(image: UIImage(named: "bg-2"))
//        imageView.contentMode = .scaleAspectFill
//        tableView.backgroundView = imageView
        tableView.tableFooterView = UIView()
    }
    
    func initField() {
        isAllDay = false
        nameTxt.text = ""
        durationTxt.text = "1 hour "
        if taskIndex != nil {
            title = "Edit Task"
            let task = tasks[taskIndex]
            
            nameTxt.text = task.name
            
            if task.startTime != nil {
                let startTime = task.startTime!
                let endTime = task.endTime!
                startTimeLbl.text = startTime
                endTimeLbl.text = endTime
                startTimePicker.date = UtilsDate.toTime(sTime: startTime)
                endTimePicker.date = UtilsDate.toTime(sTime: endTime)
            }
            else {
                isAllDay = true
            }
            
            durationTxt.text = task.duration
        }
        else {
            startTimeLbl.text = UtilsDate.roundedByFiveMinutes(time: Date())
            print(UtilsDate.toString(time: Date().addingTimeInterval(60 * 60)))
            let nowPlusHour = Date().addingTimeInterval(60 * 60)
            endTimeLbl.text = UtilsDate.roundedByFiveMinutes(time: nowPlusHour)
            endTimePicker.date = nowPlusHour
        }
        
        pickerHeight = 0
    }
    
    @IBAction func save(_ sender: Any) {
        var startTime: String? = nil
        var endTime: String? = nil
        if !isAllDay {
            startTime = UtilsDate.roundedByFiveMinutes(time: startTimePicker.date)
            endTime = UtilsDate.roundedByFiveMinutes(time: endTimePicker.date)
        }
        
        let task = Task(name: nameTxt.text!, startTime: startTime, endTime: endTime, duration: durationTxt.text!)
        
        if taskIndex != nil {
            tasks[taskIndex] = task
        }
        else {
            tasks.append(task)
        }
        
        Defaults.saveData(updatedTasks: tasks)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func updateTime(_ sender: UIDatePicker) {
        let time = UtilsDate.toString(time: sender.date)
        if sender == startTimePicker {
            startTimeLbl.text = time
        }
        else {
            endTimeLbl.text = time
        }
        
        durationTxt.text = UtilsDate.getDifference(from: startTimePicker.date, to: endTimePicker.date)
    }
    
    @IBAction func reset(_ sender: Any) {
        initField()
    }
    
    func disableCell(indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.contentView.alpha = !isAllDay ? 1 : 0.5
        cell?.isUserInteractionEnabled = !isAllDay
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case Row.startPicker:
            return startPickerHeight
        case Row.endPicker:
            return endPickerHeight
        default:
            return 40
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case Row.allDay:
            isAllDay = !isAllDay
        case Row.startTime:
            startPickerHeight = startPickerHeight != defaultPickerHeight ? defaultPickerHeight : 0
            tableView.reloadData()
        case Row.endTime:
            endPickerHeight = endPickerHeight != defaultPickerHeight ? defaultPickerHeight : 0
            tableView.reloadData()
        default:
            break
        }
    }
}
