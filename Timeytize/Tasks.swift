//
//  Tasks.swift
//  Timeytize
//
//  Created by Rahmannur Rizki Syahputra on 10/04/21.
//

import Foundation

var myTask:[String] = ["Task 1","Task 2","Task 3"]
var myTaskDeadline:[String] = ["7 April","8 April","9 April"]
var myTaskTimespan:[String] = ["69min","1hr 30min","4hr 20min"]
var myTaskPriority:[String] = ["Low","Medium","High"]
var myTaskCategory:[String] = ["graduationcap.fill","briefcase.fill","sparkles"]


//cell?.deadlineLabel.text = "\(myTaskDeadline[indexPath.row])"
//cell?.deadlineLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
//
//cell?.timespanLabel.text = "\(myTaskTimespan[indexPath.row])"
//cell?.timespanLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
//
//cell?.priorityLabel.text = "\(myTaskPriority[indexPath.row])"
//cell?.priorityLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
//
//cell?.categoryImage.image = UIImage(systemName: "\(myTaskCategory[indexPath.row])")
//cell?.categoryImage.layer.cornerRadius = 5.0
//
//if(myTaskCategory[indexPath.row]=="graduationcap.fill")
//{
//    cell?.categoryImage.backgroundColor = #colorLiteral(red: 1, green: 0.2239155173, blue: 0.4652051926, alpha: 1)
//    cell?.categoryImage.tintColor = #colorLiteral(red: 0.9490483403, green: 0.9486235976, blue: 0.9704765677, alpha: 1)
//}
//else if(myTaskCategory[indexPath.row]=="briefcase.fill"){
//    cell?.categoryImage.backgroundColor = #colorLiteral(red: 1, green: 0.5184053779, blue: 0.2123939693, alpha: 1)
//    cell?.categoryImage.tintColor = #colorLiteral(red: 0.9490483403, green: 0.9486235976, blue: 0.9704765677, alpha: 1)
//}
//else if(myTaskCategory[indexPath.row]=="sparkles"){
//    cell?.categoryImage.backgroundColor = #colorLiteral(red: 0.5431880355, green: 0.509031713, blue: 0.937476933, alpha: 1)
//    cell?.categoryImage.tintColor = #colorLiteral(red: 0.9490483403, green: 0.9486235976, blue: 0.9704765677, alpha: 1)
//}

struct Tasks {
    var name:String
    var deadline:String
    var timespan:Int
    var priority:String
    var category:String
    var subtask:[String]
    var isOpened:Bool
    var isDone: Bool
    
    static func getTaskData()->[Tasks]{
        return [
            Tasks(name: "Task 1", deadline: "30 Sep", timespan: 100, priority: "Low", category: "Academic", subtask: ["Research", "Youtube", "Pacaran"], isOpened: false, isDone: false),
            Tasks(name: "Task 2", deadline: "8 Apr", timespan: 300, priority: "Medium", category: "Work", subtask: ["Rebahan", "Scrolling ig"], isOpened: false, isDone: false),
            Tasks(name: "Task 3", deadline: "9 Apr", timespan: 200, priority: "High", category: "Personal", subtask: ["Makan"], isOpened: false, isDone: false)
        ]
    }
}

class NewTasks {
    var name: String
    var deadline: String
    var timespan: Int
    var priority: String
    var category: String
    var subtask: [String]
    var isOpened: Bool
    var isDone: Bool

    init(name:String, deadline:String, timespan:Int, priority:String, category:String, subtask:[String], isOpened:Bool, isDone:Bool) {
        self.name = name
        self.deadline = deadline
        self.timespan = timespan
        self.priority = priority
        self.category = category
        self.subtask  = subtask
        self.isOpened = isOpened
        self.isDone   = isDone
    }

    static func getTaskData() -> [NewTasks]{
        return [
            NewTasks(name: "Thesis", deadline: "Fri, 16 Apr 2021", timespan: 4800, priority: "Medium", category: "Academic", subtask: ["Do Research"], isOpened: false, isDone: false),
            NewTasks(name: "Lebaran", deadline: "Thu, 22 Apr 2021", timespan: 7200, priority: "Low", category: "Personal", subtask: ["Makan Ketupat", "Silahturahmi"], isOpened: false, isDone: false),
            NewTasks(name: "Pulang Kampung", deadline: "Fri, 23 Apr 2021", timespan: 10800, priority: "Low", category: "Personal", subtask: ["Isi bensin"], isOpened: false, isDone: false),
            NewTasks(name: "Date with Girlfriend", deadline: "Thu, 22 Apr 2021", timespan: 3600, priority: "Low", category: "Personal", subtask: ["Watch Movie"], isOpened: false, isDone: true),
            NewTasks(name: "Presentation", deadline: "Thu, 15 Apr 2021", timespan: 7200, priority: "High", category: "Work", subtask: ["Prepare Keynote", "Rehearse"], isOpened: false, isDone: true)
        ]
    }
}

var TasksList: [NewTasks] = NewTasks.getTaskData()
