//
//  primaryFilterCell.swift
//  modalSortFull
//
//  Created by Christie Nugroho on 08/04/21.
//

import UIKit

var selectedSort: String = "Recommended"

class modalSort: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //vars n enums
    var recommendedIsSelected: Bool = false
    var categoryIsSelected: Bool = false
    var priorityIsSelected: Bool = false
    var deadlineIsSelected: Bool = false
    var timespanIsSelected: Bool = false
    var overdueIsSelected: Bool = false
    
    var categoryIsOpen: Bool = false
    var priorityIsOpen: Bool = false
    var deadlineIsOpen: Bool = false
    var timespanIsOpen: Bool = false
    var overdueIsOpen: Bool = false
    var checklist: Bool = false
    
    enum category {
        case academic, work, personal, none
    }
    enum deadline {
        case nearer, further, none
    }
    enum timespan {
        case shorter, longer, none
    }
    enum priority {
        case higher, lower, none
    }
    enum overdue {
        case newer, older, none
    }
    var selectedCategory: category = .none
    var selectedDeadline: deadline = .none
    var selectedTimespan: timespan = .none
    var selectedPriority: priority = .none
    var selectedOverdue: overdue = .none
    
    //numOfSections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    

    @IBOutlet var sortInteractions: UITableView!
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        sortInteractions.delegate = self
        sortInteractions.dataSource = self
    }
    
   
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        if recommendedIsSelected || categoryIsSelected || priorityIsSelected || deadlineIsSelected || timespanIsSelected || overdueIsSelected {
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Discard Changes", comment: "Destructive Action"), style: .destructive, handler: {_ in
                selectedSort = ""
                self.dismiss(animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel Action"), style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func didTapDoneButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    //cellForRowAt indexpath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        
        let categoryChoices: [String] = ["Academic", "Work", "Personal"]
        let priorityChoices: [String] = ["Higher priority", "Lower priority"]
        let deadlineChoices: [String] = ["Nearer deadline", "Further deadline"]
        let timespanChoices: [String] = ["Longer timespan" , "Shorter timespan"]
        let overdueChoices: [String] = ["Newer overdue", "Older overdue"]
        
            if section == 0 && row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "primaryFilter", for: indexPath) as! primaryFilterCell
                cell.categoryIcon.image = UIImage(systemName: "hand.thumbsup.fill")
                cell.categoryIcon.tintColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
                cell.primaryFilter.text = "Recommended"
                cell.backgroundColor = #colorLiteral(red: 1, green: 0.7633916736, blue: 0.9065082073, alpha: 1)
                cell.checkIcon.isHidden = true
                if selectedSort == "Recommended" {
                    cell.checkIcon.isHidden = false
                } else {
                    cell.checkIcon.isHidden = true
                }
                return cell
            } else if section == 1 {
                if row == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "primaryFilter", for: indexPath) as! primaryFilterCell
                    cell.categoryIcon.image = #imageLiteral(resourceName: "Icon Category")
                    cell.primaryFilter.text = "Category"
                    cell.checkIcon.isHidden = true
                    if selectedSort == "Academic" || selectedSort == "Work" || selectedSort == "Personal" {
                        cell.checkIcon.isHidden = false
                    } else {
                        cell.checkIcon.isHidden = true
                    }
                    return cell
                } else if row != 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "secondaryFilter", for: indexPath)
                    cell.textLabel?.text = "\(categoryChoices[indexPath.row - 1])"
                    if categoryIsSelected {
                        if selectedSort == "Academic" && row == 1 {
                           cell.accessoryType = .checkmark
                       } else if selectedSort == "Work" && row == 2 {
                           cell.accessoryType = .checkmark
                       } else if selectedSort == "Personal" && row == 3 {
                           cell.accessoryType = .checkmark
                       } else {
                           cell.accessoryType = .none
                       }
                   }
                    return cell
                }
            } else if section == 2 {
                if row == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "primaryFilter", for: indexPath) as! primaryFilterCell
                    cell.categoryIcon.image = #imageLiteral(resourceName: "Icon Priority")
                    cell.primaryFilter.text = "Priority"
                    if selectedSort == "Higher" || selectedSort == "Lower" {
                        cell.checkIcon.isHidden = false
                    } else {
                        cell.checkIcon.isHidden = true
                    }
                    return cell
                } else if row != 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "secondaryFilter", for: indexPath)
                    cell.textLabel?.text = "\(priorityChoices[indexPath.row - 1])"
                    if priorityIsSelected {
                       if selectedSort == "Higher" && row == 1 {
                           cell.accessoryType = .checkmark
                       } else if selectedSort == "Lower" && row == 2 {
                           cell.accessoryType = .checkmark
                       } else {
                           cell.accessoryType = .none
                       }
                   }
                    return cell
                }
            } else if section == 3 {
                if row == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "primaryFilter", for: indexPath) as! primaryFilterCell
                    cell.categoryIcon.image = #imageLiteral(resourceName: "Icon Deadline")
                    cell.primaryFilter.text = "Deadline"
                    if selectedSort == "Nearer" || selectedSort == "Further"{
                        cell.checkIcon.isHidden = false
                    } else {
                        cell.checkIcon.isHidden = true
                    }
                    return cell
                } else if row != 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "secondaryFilter", for: indexPath)
                    cell.textLabel?.text = "\(deadlineChoices[indexPath.row - 1])"
                    if deadlineIsSelected {
                       if selectedSort == "Nearer" && row == 1 {
                           cell.accessoryType = .checkmark
                       } else if selectedSort == "Further" && row == 2 {
                           cell.accessoryType = .checkmark
                       } else {
                           cell.accessoryType = .none
                       }
                   }
                    return cell
                }
            } else if section == 4 {
                if row == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "primaryFilter", for: indexPath) as! primaryFilterCell
                    cell.categoryIcon.image = #imageLiteral(resourceName: "Icon Timespan")
                    cell.primaryFilter.text = "Timespan"
                    if selectedSort == "Longer" || selectedSort == "Shorter" {
                        cell.checkIcon.isHidden = false
                    } else {
                        cell.checkIcon.isHidden = true
                    }
                    return cell
                } else if row != 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "secondaryFilter", for: indexPath)
                    cell.textLabel?.text = "\(timespanChoices[indexPath.row - 1])"
                    if timespanIsSelected {
                       if selectedSort == "Longer" && row == 1 {
                           cell.accessoryType = .checkmark
                       } else if selectedSort == "Shorter" && row == 2 {
                           cell.accessoryType = .checkmark
                       } else {
                           cell.accessoryType = .none
                       }
                   }
                    return cell
                }
            } else if section == 5 {
                if row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "primaryFilter", for: indexPath) as! primaryFilterCell
                    cell.categoryIcon.image = #imageLiteral(resourceName: "Icon Overdue")
                    cell.primaryFilter.text = "Overdue"
                    if selectedSort == "Overdue" {
                        cell.checkIcon.isHidden = false
                    } else {
                        cell.checkIcon.isHidden = true
                    }
                    return cell
                } else if row != 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "secondaryFilter", for: indexPath)
                    cell.textLabel?.text = "\(overdueChoices[indexPath.row - 1])"
                    if overdueIsSelected == true {
                       if selectedSort == "Overdue" && row == 1 {
                           cell.accessoryType = .checkmark
                       } else if selectedSort == "Overdue" && row == 2 {
                           cell.accessoryType = .checkmark
                       } else {
                           cell.accessoryType = .none
                       }
                   }
                return cell
                }
            }
        return UITableViewCell()
    }
    

    //numOfRowsInSections
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0: return 1
            case 1: do {
                if categoryIsOpen {
                    return 4
                } else {
                    return 1
                }
            }
            case 2: do {
                if priorityIsOpen {
                    return 3
                } else {
                    return 1
                }
            }
            case 3: do {
                if deadlineIsOpen {
                    return 3
                } else {
                    return 1
                }
            }
            case 4: do {
                if timespanIsOpen {
                    return 3
                } else {
                    return 1
                }
            }
            case 5: do {
                if overdueIsOpen {
                        return 3
                    } else {
                        return 1
                    }
            }
            case 6: return 1
            default:
                fatalError("Unknown number of sections")
        }
    }

    //didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        let cell = tableView.cellForRow(at: indexPath)
        
        if row == 0 && section != 0 {
            if section == 1 {
                categoryIsOpen = !categoryIsOpen
                if categoryIsOpen {
                    categoryIsSelected = true
                    priorityIsSelected = false
                    deadlineIsSelected = false
                    timespanIsSelected = false
                    overdueIsSelected = false
                }
                tableView.reloadSections([section], with: .automatic)
            } else if section == 2 {
                priorityIsOpen = !priorityIsOpen
                if priorityIsOpen {
                    categoryIsSelected = false
                    priorityIsSelected = true
                    deadlineIsSelected = false
                    timespanIsSelected = false
                    overdueIsSelected = false
                }
                tableView.reloadSections([section], with: .automatic)
            } else if section == 3 {
                deadlineIsOpen = !deadlineIsOpen
                if deadlineIsOpen {
                    categoryIsSelected = false
                    priorityIsSelected = false
                    deadlineIsSelected = true
                    timespanIsSelected = false
                    overdueIsSelected = false
                }
                tableView.reloadSections([section], with: .automatic)
            }
            else if section == 4 {
                timespanIsOpen = !timespanIsOpen
                if timespanIsOpen {
                    categoryIsSelected = false
                    priorityIsSelected = false
                    deadlineIsSelected = false
                    timespanIsSelected = true
                    overdueIsSelected = false
                }
                tableView.reloadSections([section], with: .automatic)
            }
            else if section == 5 {
                overdueIsOpen = !overdueIsOpen
                if overdueIsOpen {
                    categoryIsSelected = false
                    priorityIsSelected = false
                    deadlineIsSelected = false
                    timespanIsSelected = false
                    overdueIsSelected = true
                }
                tableView.reloadSections([section], with: .automatic)
            }
            print(categoryIsSelected)
            print(priorityIsSelected)
            print(deadlineIsSelected)
            print(timespanIsSelected)
            print(overdueIsSelected)
            return
        }
        
        if section == 0 && row == 0 {
            selectedSort = "Recommended"
            let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? primaryFilterCell
            print(selectedSort)
            cell?.checkIcon.isHidden = false
        } else if section == 1 && row != 0 {
            categoryIsSelected = true
            switch row {
                case 1: selectedSort = "Academic"
                case 2: selectedSort = "Work"
                case 3: selectedSort = "Personal"
                default: selectedSort = "None"
            }
            let categoryCell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? primaryFilterCell
            categoryCell?.checkIcon.isHidden = false
            cell?.accessoryType = .checkmark
        }else if section == 2 && row != 0 {
            switch row {
                case 1: selectedSort = "Higher"
                case 2: selectedSort = "Lower"
                default: selectedSort = "None"
            }
            let priorityCell = tableView.cellForRow(at: IndexPath(row: 0, section: 2)) as? primaryFilterCell
            priorityCell?.checkIcon.isHidden = false
            cell?.accessoryType = .checkmark
        }else if section == 3 && row != 0 {
            switch row {
                case 1: selectedSort = "Nearer"
                case 2: selectedSort = "Further"
                default: selectedSort = "None"
            }
            let deadlineCell = tableView.cellForRow(at: IndexPath(row: 0, section: 3)) as? primaryFilterCell
            deadlineCell?.checkIcon.isHidden = false
            cell?.accessoryType = .checkmark
        }else if section == 4 && row != 0 {
            switch row {
                case 1: selectedSort = "Longer"
                case 2: selectedSort = "Shorter"
                default: selectedSort = "None"
            }
            let timespanCell = tableView.cellForRow(at: IndexPath(row: 0, section: 4)) as? primaryFilterCell
            timespanCell?.checkIcon.isHidden = false
            cell?.accessoryType = .checkmark
        }else if section == 5 && row != 0 {
            switch row {
            case 1: selectedSort = "Overdue"
            case 2: selectedSort = "Overdue"
            default: selectedSort = "None"
            }
            let overdueCell = tableView.cellForRow(at: IndexPath(row: 0, section: 5)) as? primaryFilterCell
            overdueCell?.checkIcon.isHidden = false
            cell?.accessoryType = .checkmark
        }
        tableView.reloadData()
        print(selectedSort)
    }
    
    //didDeselectRow
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? primaryFilterCell
        if indexPath.row == 0 {
            cell?.checkIcon.isHidden = true
            print("did deselect")
        } else {
            cell?.accessoryType = .none
        }
        
    }
    
    //footerHeight
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
            
    //rowHeight
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
