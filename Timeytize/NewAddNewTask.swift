//
//  NewAddNewTask.swift
//  Timeytize-2
//
//  Created by Nico Christian on 08/04/21.
//

import UIKit
import CoreData

class NewAddNewTask: UIViewController, UITextFieldDelegate {

    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var addButtonOutlet: UIBarButtonItem!
    var taskName: String = ""
    var taskNameIsSet: Bool = false
    var categoryIsOpened: Bool = false
    var priorityIsOpened: Bool = false
    var deadlineIsOpened: Bool = false
    var timeSpanIsOpened: Bool = false
    var switchOn: Bool = false
    var taskTaskFieldCell: CellWithTextField = CellWithTextField()
    var subtaskCell: CellSubtask = CellSubtask()
    var deadlineValue: String = ""
    var timespanValue: Double = 60
    
    var categoryIsSet: Bool = false
    var categorySwitchIsOn: Bool = false
    var categoryIndexSelected: IndexPath = IndexPath(row: 0, section: 1)
    
    var priorityIsSet: Bool = false
    var prioritySwitchIsOn: Bool = false
    var priorityIndexSelected: IndexPath = IndexPath(row: 0, section: 2)
    
    var deadlineIsSet: Bool = false
    var deadlineSwitchIsOn: Bool = false
    
    var timeSpanIsSet: Bool = false
    var timeSpanSwitchIsOn: Bool = false
    
    var editMode: Bool = false
    var editTaskIndex: Int = -1
    
    var selectedCategory: String = ""
    var selectedPriority: String = ""
    var subtasks: [String] = []
    
    var activeTextField: UITextField? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        deadlineValue = dateToString(date: Date())
        addButtonOutlet.isEnabled = false
        if editMode && editTaskIndex != -1 {
            initializeVariables(index: editTaskIndex)
            addButtonOutlet.isEnabled = true
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let subtaskCell = tableView.cellForRow(at: IndexPath(row: 0, section: 5)) as? CellSubtask
        let subtaskTextField = subtaskCell?.subtaskTextField
        subtaskTextField?.delegate = self
        
        let taskNameCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? CellWithTextField
        let taskNameTaskField = taskNameCell?.taskNameTextField
        taskNameTaskField?.delegate = self
    }
    
    @objc func subtaskTextFieldBeginEdit(textField: UITextField){
        print("Masuk")
        activeTextField = textField
    }
    
    @objc func subtaskTextFieldEndEdit(textField: UITextField) {
        print("end masuk")
        activeTextField = nil
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        var shouldMoveUp = false
        print(subtaskCell)
        if let textField = activeTextField {
            let bottomOfTextField = textField.convert(textField.bounds, to: self.view).maxY
            let topOfTextField = self.view.frame.height - keyboardSize.height
            print(bottomOfTextField)
            print(topOfTextField)
            if bottomOfTextField > topOfTextField {
                shouldMoveUp = true
            }
        }
        if shouldMoveUp {
            self.view.frame.origin.y = 0 - keyboardSize.height / 1.5
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
      self.view.frame.origin.y = 0
    }
    
    func initializeVariables(index: Int){
        taskNameIsSet = true
        categoryIsSet = true
        priorityIsSet = true
        deadlineIsSet = true
        timeSpanIsSet = true
        taskName = sortedArr[index].name
        deadlineValue = sortedArr[index].deadline
        timespanValue = Double(sortedArr[index].timespan)
        selectedCategory = sortedArr[index].category
        selectedPriority = sortedArr[index].priority
        for task in sortedArr[index].subtask {
            subtasks.append(task)
        }
        self.title = "Edit Task"
        self.navigationItem.rightBarButtonItem?.title = "Done"
    }

    @IBAction func didTapCancelButton(_ sender: UIBarButtonItem) {
        if taskName != "" || categoryIsSet || priorityIsSet || deadlineIsSet || timeSpanIsSet || subtasks.count > 0 {
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Discard Changes", comment: "Destructive Action"), style: .destructive, handler: {_ in
                self.dismiss(animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel Action"), style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM y"
        return formatter.string(from: (date))
    }
    
    func secondsToString(seconds: Double) -> String {
        let hours = Int(seconds/3600)
        let minutes = Int(seconds.truncatingRemainder(dividingBy: 3600) / 60)
        return "\(hours) Hours \(minutes) Min"
    }
    
    func checkAddButton() {
        if taskName != "" && categoryIsSet {
            addButtonOutlet.isEnabled = true
        }
    }
}

extension NewAddNewTask: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        // MARK: Expand Colapse
        if row == 0 {
            if section == 1 {
                categoryIsOpened = !categoryIsOpened
                if categoryIsOpened {
                    categorySwitchIsOn = true
                    categoryIsSet = true
                }
                tableView.reloadSections([section], with: .automatic)
            } else if section == 2 {
                priorityIsOpened = !priorityIsOpened
                if priorityIsOpened{
                    prioritySwitchIsOn = true
                    priorityIsSet = true
                }
                tableView.reloadSections([section], with: .automatic)
            } else if section == 3 {
                deadlineIsOpened = !deadlineIsOpened
                if deadlineIsOpened {
                    deadlineIsSet = true
                    deadlineSwitchIsOn = true
                }
                tableView.reloadSections([section], with: .automatic)
            }
            else if section == 4 {
                timeSpanIsOpened = !timeSpanIsOpened
                if timeSpanIsOpened {
                    timeSpanIsSet = true
                    timeSpanSwitchIsOn = true
                }
                tableView.reloadSections([section], with: .automatic)
            }
        }
        
        // MARK: Checkmark Selection
        if section == 1 && row >= 1  && row <= 3{
            let cell = tableView.cellForRow(at: indexPath) as? CellChoices
            cell?.accessoryType = .checkmark
            categoryIsSet = true
            checkAddButton()
            switch row {
                case 1: selectedCategory = "Academic"
                case 2: selectedCategory = "Work"
                case 3: selectedCategory = "Personal"
                default: selectedCategory = ""
            }
            categoryIndexSelected = IndexPath(row: row, section: section)
            tableView.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .none) // reload row 0 subtitle label
//            print(categoryIndexSelected)
        } else if section == 2 && row >= 1  && row <= 4 {
            let cell = tableView.cellForRow(at: indexPath) as? CellChoices
            cell?.accessoryType = .checkmark
            switch row {
                case 1: selectedPriority = "High"
                case 2: selectedPriority = "Medium"
                case 3: selectedPriority = "Low"
                case 4: selectedPriority = "None"
                default: selectedPriority = ""
            }
            priorityIndexSelected = IndexPath(row: row, section: section)
            tableView.reloadRows(at: [IndexPath(row: 0, section: 2)], with: .none) // reload row 0 subtitle label
            print(selectedPriority)
        }
        print("\(indexPath) &  selected")
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? CellChoices
        cell?.accessoryType = .none
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0: return 1
            case 1: do {
                if categoryIsOpened {
                    return 4
                } else {
                    return 1
                }
            }
            case 2: do {
                if priorityIsOpened {
                    return 4
                } else {
                    return 1
                }
            }
            case 3: do {
                if deadlineIsOpened {
                    return 2
                } else {
                    return 1
                }
            }
            case 4: do {
                if timeSpanIsOpened {
                    return 2
                } else {
                    return 1
                }
            }
            case 5: do {
                if subtasks.count > 0 {
                    return subtasks.count + 1
                } else {
                    return 1
                }
            }
            default:
                fatalError("Unknown number of sections")
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        let row = indexPath.row
        
        let categoryChoices: [String] = ["Academic", "Work", "Personal", "None"]
        let priorityChoices: [String] = ["High", "Medium", "Low"]
        
        let switchView = UISwitch(frame: .zero)
        switchView.tag = section
        switchView.onTintColor = #colorLiteral(red: 0.9921568627, green: 0.3137254902, blue: 0.4705882353, alpha: 1)
        switchView.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        
        // Ganti switch jadi on pas expand, off kalo di colapse
        
        if categorySwitchIsOn && switchView.tag == 1 || editMode {
            switchView.isOn = true
        }
        if prioritySwitchIsOn && switchView.tag == 2 || editMode {
            switchView.isOn = true
        }
        if deadlineSwitchIsOn && switchView.tag == 3 || editMode {
            switchView.isOn = true
        }
        if timeSpanSwitchIsOn && switchView.tag == 4 || editMode {
            switchView.isOn = true
        }
        
        if section == 0 && row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellWithTextField", for: indexPath) as! CellWithTextField
            if taskNameIsSet {
                cell.taskNameTextField.text = taskName
            }
            cell.taskNameTextField.addTarget(self, action: #selector(didEditTaskNameTextField), for: .editingChanged)
            taskTaskFieldCell = cell
            return cell
        } else if section == 1 {
            if row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellWithImage", for: indexPath) as! CellWithImage
                cell.titleLabel.text = "Category"
                if categoryIsSet == false {
                    cell.titleLabel.frame = CGRect(x: cell.titleLabel.frame.minX, y: 25, width: cell.titleLabel.frame.width, height: cell.titleLabel.frame.height)
                    cell.subtitleLabel.isHidden = true
                } else {
                    cell.titleLabel.frame = CGRect(x: cell.titleLabel.frame.minX, y: 15, width: cell.titleLabel.frame.width, height: cell.titleLabel.frame.height)
                    cell.subtitleLabel.text = selectedCategory
                    cell.subtitleLabel.isHidden = false
                }
                cell.iconImage.image = UIImage(named: "Icon Category")
                cell.accessoryView = switchView
                return cell
            } else if row != 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellChoices", for: indexPath) as! CellChoices
                cell.titleLabel.text = categoryChoices[indexPath.row - 1]
                cell.accessoryType = .none
                if categoryIsSet {
                    if selectedCategory == "Academic" && row == 1 {
                        cell.accessoryType = .checkmark
                    } else if selectedCategory == "Work" && row == 2 {
                        cell.accessoryType = .checkmark
                    } else if selectedCategory == "Personal" && row == 3 {
                        cell.accessoryType = .checkmark
                    } else {
                        cell.accessoryType = .none
                    }
                }
                return cell
            }
        } else if section == 2 {
            if row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellWithImage", for: indexPath) as! CellWithImage
                cell.titleLabel.text = "Priority"
                if priorityIsSet == false {
                    cell.titleLabel.frame = CGRect(x: cell.titleLabel.frame.minX, y: 25, width: cell.titleLabel.frame.width, height: cell.titleLabel.frame.height)
                    cell.subtitleLabel.isHidden = true
                } else {
                    cell.titleLabel.frame = CGRect(x: cell.titleLabel.frame.minX, y: 15, width: cell.titleLabel.frame.width, height: cell.titleLabel.frame.height)
                    cell.subtitleLabel.text = selectedPriority
//                    switch selectedPriority {
//                        case .high: cell.subtitleLabel.text = "High"
//                        case .medium: cell.subtitleLabel.text = "Medium"
//                        case .low: cell.subtitleLabel.text = "Low"
//                        default: cell.subtitleLabel.text = "No Priority Selected"
//                    }
                    cell.subtitleLabel.isHidden = false
                }
                cell.iconImage.image = UIImage(named: "Icon Priority")
                cell.accessoryView = switchView
                return cell
            } else if row != 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellChoices", for: indexPath) as! CellChoices
                cell.titleLabel.text = priorityChoices[indexPath.row - 1]
                if priorityIsSet {
                    if selectedPriority == "High" && row == 1 {
                        cell.accessoryType = .checkmark
                    } else if selectedPriority == "Medium" && row == 2 {
                        cell.accessoryType = .checkmark
                    } else if selectedPriority == "Low" && row == 3 {
                        cell.accessoryType = .checkmark
                    } else if selectedPriority == "None" && row == 4 {
                        cell.accessoryType = .checkmark
                    } else {
                        cell.accessoryType = .none
                    }
                }
                return cell
            }
        }
        else if section == 3 {
            
            if row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellWithImage", for: indexPath) as! CellWithImage
                cell.titleLabel.text = "Deadline"
                if deadlineIsSet == false {
                    cell.titleLabel.frame = CGRect(x: cell.titleLabel.frame.minX, y: 25, width: cell.titleLabel.frame.width, height: cell.titleLabel.frame.height)
                    cell.subtitleLabel.isHidden = true
                } else {
                    cell.titleLabel.frame = CGRect(x: cell.titleLabel.frame.minX, y: 15, width: cell.titleLabel.frame.width, height: cell.titleLabel.frame.height)
                    cell.subtitleLabel.text = deadlineValue
                    cell.subtitleLabel.isHidden = false
                }
                cell.iconImage.image = UIImage(named: "Icon Deadline")
                cell.accessoryView = switchView
                return cell
            } else if row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellDeadline", for: indexPath) as! CellDeadline
                cell.deadlineDatePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
                return cell
            }
        } else if section == 4 {
            if row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellWithImage", for: indexPath) as! CellWithImage
                cell.titleLabel.text = "Time Span"
                if timeSpanIsSet == false {
                    cell.titleLabel.frame = CGRect(x: cell.titleLabel.frame.minX, y: 25, width: cell.titleLabel.frame.width, height: cell.titleLabel.frame.height)
                    cell.subtitleLabel.isHidden = true
                } else {
                    cell.titleLabel.frame = CGRect(x: cell.titleLabel.frame.minX, y: 15, width: cell.titleLabel.frame.width, height: cell.titleLabel.frame.height)
                    cell.subtitleLabel.text = secondsToString(seconds: timespanValue)
                    cell.subtitleLabel.isHidden = false
                }
                cell.iconImage.image = UIImage(named: "Icon Timespan")
                cell.accessoryView = switchView
                return cell
            } else if row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellTimeSpan", for: indexPath) as! CellTimeSpan
                cell.timeSpanDatePicker.addTarget(self, action: #selector(timeSpanPickerValueChanged), for: .valueChanged)
                timespanValue = cell.timeSpanDatePicker.countDownDuration
                return cell
            }
        } else if section == 5 {
            if row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellSubtask", for: indexPath) as! CellSubtask
                let button = UIButton()
                let image = UIImage(systemName: "plus")
                button.setImage(image, for: .normal)
                button.sizeToFit()
                button.addTarget(self, action: #selector(didTapSubtaskButton), for: .touchUpInside)
                cell.accessoryView = button
                subtaskCell = cell
                cell.subtaskTextField.addTarget(self, action: #selector(subtaskTextFieldBeginEdit), for: .editingDidBegin)
                cell.subtaskTextField.addTarget(self, action: #selector(subtaskTextFieldEndEdit), for: .editingDidEnd)
                return cell
            } else if row != 0 && subtasks.count > 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "PlainCell", for: indexPath)
                let button = UIButton()
                let image = UIImage(systemName: "minus.circle.fill")
                button.tintColor = #colorLiteral(red: 0.9921568627, green: 0.3137254902, blue: 0.4705882353, alpha: 1)
                button.setImage(image, for: .normal)
                button.sizeToFit()
                button.tag = indexPath.row - 1
                button.addTarget(self, action: #selector(didTapDeleteSubtaskButton), for: .touchUpInside)
                cell.textLabel?.text = subtasks[row - 1]
                cell.accessoryView = button
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 3 && indexPath.row == 1{
            return 320
        } else if indexPath.section == 4 && indexPath.row == 1 {
            return 160
        }
        return 70
    }
    
    @objc func switchValueChanged(_ sender: UISwitch){
        let tag = sender.tag
        print("table row switch Changed \(sender.tag)")
        print("The switch is \(sender.isOn ? "ON" : "OFF")")
        
        if tag == 1 {
            if categorySwitchIsOn {
                categorySwitchIsOn = false
                categoryIsOpened = false
                categoryIsSet = false
                addButtonOutlet.isEnabled = false
            } else {
                categorySwitchIsOn = true
                categoryIsOpened = true
                categoryIsSet = true
            }
            tableView.reloadSections([tag], with: .automatic)
        } else if tag == 2 {
            if prioritySwitchIsOn {
                prioritySwitchIsOn = false
                priorityIsOpened = false
                priorityIsSet = false
            } else {
                prioritySwitchIsOn = true
                priorityIsOpened = true
                priorityIsSet = true
            }
            tableView.reloadSections([tag], with: .automatic)
        } else if tag == 3 {
            if deadlineSwitchIsOn {
                deadlineSwitchIsOn = false
                deadlineIsOpened = false
                deadlineIsSet = false
            } else {
                deadlineSwitchIsOn = true
                deadlineIsOpened = true
                deadlineIsSet = true
            }
            tableView.reloadSections([tag], with: .automatic)
        }
        else if tag == 4 {
            if timeSpanSwitchIsOn {
                timeSpanSwitchIsOn = false
                timeSpanIsOpened = false
                timeSpanIsSet = false
            } else {
                timeSpanSwitchIsOn = true
                timeSpanIsOpened = true
                timeSpanIsSet = true
            }
            tableView.reloadSections([tag], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0: return 24
        case 1: return 8
        case 2: return 32
        case 3: return 8
        case 4: return 8
        case 5: return 8
        default:
            return 16
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0: return 8
        case 1: return 32
        case 2: return 8
        case 3: return 8
        case 4: return 8
        case 5: return 8
        default:
            return 16
        }
    }
    
    @objc func didEditTaskNameTextField(_ sender: UITextField) {
        taskName = sender.text ?? ""
        checkAddButton()
    }
    
    @objc func didTapSubtaskButton(_ sender: UIButton) {
        let subtaskName = subtaskCell.subtaskTextField.text!
        if subtaskName == "" {
            return
        }
        subtasks.append(subtaskName)
        let indexPath = IndexPath(row: subtasks.count, section: 5)
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.reloadData()
    }
    
    @objc func didTapDeleteSubtaskButton(_ sender: UIButton) {
        print("delete button tapped")
        print(sender.tag)
        subtasks.remove(at: sender.tag)
        tableView.reloadData()
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let deadlineCellTitle = tableView.cellForRow(at: IndexPath(row: 0, section: 3)) as? CellWithImage
        deadlineCellTitle?.subtitleLabel.text = dateToString(date: sender.date)
        deadlineValue = dateToString(date: sender.date)
    }
    
    @objc func timeSpanPickerValueChanged(_ sender: UIDatePicker) {
        let timeSpanCellTitle = tableView.cellForRow(at: IndexPath(row: 0, section: 4)) as? CellWithImage
        let seconds = sender.countDownDuration
        timeSpanCellTitle?.subtitleLabel.text = secondsToString(seconds: seconds)
        timespanValue = seconds
    }
    
    @IBAction func didTapAddButton(_ sender: UIBarButtonItem) {
        taskName = taskTaskFieldCell.taskNameTextField.text ?? ""
        
        if priorityIsSet == false {
            selectedPriority = "NotSet"
        }
        if deadlineIsSet == false {
            deadlineValue = "NotSet"
        }
        if timeSpanIsSet == false {
            timespanValue = 0
        }
        
        let task: NewTasks = NewTasks(name: taskName, deadline: deadlineValue, timespan: Int(timespanValue), priority: selectedPriority, category: selectedCategory, subtask: subtasks, isOpened: false, isDone: false)
        if editMode {
            TasksList[editTaskIndex] = task
        } else {
            TasksList.append(task)
        }

        print(task.name)
        print(task.category)
        print(task.priority)
        print(task.deadline)
        print(task.timespan)
        print(task.subtask)
        
        self.dismiss(animated: true, completion: { print("dismiss") })
    }
}

extension UITextField{
   @IBInspectable var doneAccessory: Bool{
       get{
           return self.doneAccessory
       }
       set (hasDone) {
           if hasDone{
               addDoneButtonOnKeyboard()
           }
       }
   }

   func addDoneButtonOnKeyboard() {
       let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
       doneToolbar.barStyle = .default
       let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
       let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
       let items = [flexSpace, done]
       doneToolbar.items = items
       doneToolbar.sizeToFit()
       self.inputAccessoryView = doneToolbar
   }
   @objc func doneButtonAction() {
       self.resignFirstResponder()
   }
}
