//
//  taskTableViewController.swift
//  Timeytize
//
//  Created by Rahmannur Rizki Syahputra on 10/04/21.
//

import UIKit

class taskTableViewController:UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var tasks:[Tasks]=Tasks.getTaskData()
    
    func secondsToString(seconds: Double) -> String {
        let hours = Int(seconds/3600)
        let minutes = Int(seconds.truncatingRemainder(dividingBy: 3600) / 60)
        return "\(hours) Hours \(minutes) Min"
    }

    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let task = tasks[section]
        if task.isOpened{
            return task.subtask.count + 1
        }
        else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0{
            // Nampilin Major Task Title

            let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! customTaskTableViewController
            
            let fonttitle = UIFont.systemFont(ofSize: 17, weight: .semibold)
            let fontsubtitle = UIFont.systemFont(ofSize: 14, weight: .regular)
            
//            ngecek ada subtask apa kagak, kalo ada baru kasih chevron
            if tasks[indexPath.section].subtask.count > 0{
                cell.categoryChevron.image = UIImage(systemName: "chevron.down")
            }
            
            
            cell.taskLable.text = tasks[indexPath.section].name
            cell.taskLable.textColor = #colorLiteral(red: 0.1838639081, green: 0.1525175273, blue: 0.382268846, alpha: 1)
            cell.taskLable.font = fonttitle
            
            cell.deadlineLabel.text = tasks[indexPath.section].deadline
            cell.deadlineLabel.font = fontsubtitle
            cell.deadlineLabel.textColor = #colorLiteral(red: 0.5607843137, green: 0.5490196078, blue: 0.6666666667, alpha: 1)
            
            cell.timespanLabel.text = secondsToString(seconds: Double(tasks[indexPath.section].timespan))
            cell.timespanLabel.font = fontsubtitle
            cell.timespanLabel.adjustsFontSizeToFitWidth = true
            cell.timespanLabel.textColor = #colorLiteral(red: 0.5607843137, green: 0.5490196078, blue: 0.6666666667, alpha: 1)
            
            cell.priorityLabel.text = tasks[indexPath.section].priority
            cell.priorityLabel.font = fontsubtitle
            cell.priorityLabel.textColor = #colorLiteral(red: 0.5607843137, green: 0.5490196078, blue: 0.6666666667, alpha: 1)
            
            if tasks[indexPath.section].category == "graduationcap.fill"{
                cell.categoryImage.image = #imageLiteral(resourceName: "label1")
            }
            else if tasks[indexPath.section].category == "briefcase.fill"{
                cell.categoryImage.image = #imageLiteral(resourceName: "label2")
            }
            else if tasks[indexPath.section].category == "sparkles"{
                cell.categoryImage.image = #imageLiteral(resourceName: "label3")
            }
            
            return cell
        }
        else{
            // Nampilin subtask

            let subCell = tableView.dequeueReusableCell(withIdentifier: "customSubCell", for: indexPath) as! UITableViewCell
            
            let font = UIFont.systemFont(ofSize: 17, weight: .semibold)
            subCell.textLabel?.font = font
            subCell.textLabel?.textColor = #colorLiteral(red: 0.1838639081, green: 0.1525175273, blue: 0.382268846, alpha: 1)
            
            subCell.textLabel?.text = tasks[indexPath.section].subtask[indexPath.row - 1]
            return subCell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let task = tasks[indexPath.section]
        
        if task.isOpened && indexPath.row != 0{
            return 50
        }
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        dropdown si subtask nya
        
        tableView.deselectRow(at: indexPath, animated: true)
        let section = indexPath.section
        let row = indexPath.row
        
        var categoryCellExpanded: Bool = false
        print(section)
        print(row)

        // Code Animasi chevron

        let cell = tableView.cellForRow(at: indexPath) as! customTaskTableViewController
        
        if indexPath.row == 0 && categoryCellExpanded == false{
            
            tasks[indexPath.section].isOpened = !tasks[indexPath.section].isOpened
            tableView.reloadSections([indexPath.section], with: .none)
            
            cell.categoryChevron.image = UIImage(systemName: "chevron.up")
            categoryCellExpanded = true
            
            UIView.animate(withDuration: 0.2){ cell.categoryChevron.transform = CGAffineTransform(rotationAngle: .pi)}
            print("tes")
        }
        else{

            print("Subcell")
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    // Mark: - swipe action
    // Mark: - Delete row and Done row
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, success) in
            print("Edit tapped")
            success(true)
        }
        
        let modifyAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("Update action ...")
            success(true)

            let alertView = UIAlertController(title: "Alert", message: "Are you sure you want to delete this task ? ", preferredStyle: .alert)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (alert) in
//                self.tasks.remove(at: indexPath.row)
//                tableView.deleteRows(at: [indexPath], with: .fade)
                print(indexPath.row)
            })
            let cancelAction = UIAlertAction(title: "Cancel", style:.cancel, handler: { (alert) in
                print("Cancel")
            })
            
            alertView.addAction(deleteAction)
            alertView.addAction(cancelAction)
            self.present(alertView, animated: true, completion: nil)

            })
        modifyAction.backgroundColor = #colorLiteral(red: 1, green: 0.2239155173, blue: 0.4652051926, alpha: 1)
            
        return UISwipeActionsConfiguration(actions: [modifyAction, editAction])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        var task = tasks[indexPath.row]
        let doneAction = UIContextualAction(style: .normal, title: "Done") { (action, view, success) in
            
            success(true)
            
            let doneAlertView = UIAlertController(title: "Task Finished", message: "Congratulations you have finished a task!! 🥳", preferredStyle: .alert)
                
            let doneAlertAction = UIAlertAction(title: "Continue", style: .default) { (alert) in
//                print("Task \(indexPath.row) is DONE")
//                self.tasks.remove(at: indexPath.row)
//                var task = self.tasks[indexPath.row]
//                task.isDone.toggle()
//                self.tasks[indexPath.row].isDone = true
                self.tasks.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            doneAlertView.addAction(doneAlertAction)
            self.present(doneAlertView, animated: true, completion: nil)
        }
        doneAction.backgroundColor = #colorLiteral(red: 0.1838639081, green: 0.1525175273, blue: 0.382268846, alpha: 1)
        return UISwipeActionsConfiguration(actions: [doneAction])
    }
}
    
