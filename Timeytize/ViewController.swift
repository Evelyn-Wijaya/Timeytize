//
//  ViewController.swift
//  MC1.2 - Eve printilan
//
//  Created by Evelyn Wijaya on 05/04/21.
//

import UIKit

var sortedArr: [NewTasks] = TasksList

class ViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var models = [Task]()
    var temp: [NewTasks] = [NewTasks]()
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var navBarTaskList: UINavigationItem!
    
    //Segmented Control
    @IBOutlet weak var filterSegmented: UISegmentedControl!
    @IBOutlet weak var containerFilterSegmented: UIView!
    
    //Btn SortBy
    @IBOutlet weak var btnSortBy: UIButton!
    
    //SortLabel
    @IBOutlet weak var testSortLabel: UILabel!
    @IBOutlet weak var sfSortLabel: UIImageView!
    @IBOutlet weak var containerSortLabel: UIView!
    
    //Buttons dummy untuk pilih sortby dan override label
    @IBOutlet weak var dumRecommended: UIButton!
    
    @IBOutlet weak var dumCategoryAcademic: UIButton!
    @IBOutlet weak var dumCategoryWork: UIButton!
    @IBOutlet weak var dumCategoryPersonal: UIButton!
    //deadline
    @IBOutlet weak var dumNearerDeadline: UIButton!
    @IBOutlet weak var dumFurtherDeadline: UIButton!
    //timespan
    @IBOutlet weak var dumLongerTimespan: UIButton!
    @IBOutlet weak var dumShorterTimespan: UIButton!
    //priority
    @IBOutlet weak var dumHigherPriority: UIButton!
    @IBOutlet weak var dumLowerPriority: UIButton!
    //overdue
    @IBOutlet weak var dumNewerOverdue: UIButton!
    @IBOutlet weak var dumOlderOverdue: UIButton!
    
    
    @IBAction func testButton(_ sender: Any) {
        refreshTable()
    }
    
    @IBAction func didTapAddButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "AddNewTaskSegue", sender: self)
    }
    
    func sortByApa(filter: String) {
        
    }
    
    func nearestSort() -> [NewTasks] {
        var dateSorted: [NewTasks] = [NewTasks]()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM y"
        
        var deadlineArr: [Date] = [Date]()
        for i in TasksList {
            let date = i.deadline
            let dateFromString = dateFormatter.date(from: date) ?? Date()
            deadlineArr.append(dateFromString)
        }
        deadlineArr = deadlineArr.sorted{$0 < $1}
        var uniqueDate: [Date] = [Date]()
        for i in deadlineArr {
            if uniqueDate.contains(i) == false {
                uniqueDate.append(i)
            }
        }
        for i in uniqueDate {
            for j in sortedArr {
                let date = j.deadline
                let dateFromString = dateFormatter.date(from: date) ?? Date()
                if i == dateFromString {
                    dateSorted.append(j)
                }
            }
        }
        sortedArr = dateSorted
        return sortedArr
    }
    
    func recomendedSort() -> [NewTasks] {
        let sortedRecommended: [NewTasks] = sortedArr.sorted { (lhs, rhs) in
            if stringToDate(date: lhs.deadline) == stringToDate(date: rhs.deadline) {
//                if lhs.timespan == rhs.timespan { // <1>
//                    return lhs.name < rhs.name
//                }
                return lhs.timespan > rhs.timespan
            }
            return stringToDate(date: lhs.deadline) < stringToDate(date: rhs.deadline)
        }
        return sortedRecommended
    }
    
    func stringToDate(date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM y"
        return dateFormatter.date(from: date) ?? Date()
    }
    
    @IBAction func didTapSortButton(_ sender: UIButton) {
        
    }
    
    func sortFunction() {
        containerSortLabel.isHidden = false
        sortedArr = TasksList
        if selectedSort == "Recommended" {
            sortedArr = recomendedSort()
            labelRecommended()
        } else if selectedSort == "Academic"  || selectedSort == "Work" || selectedSort == "Personal" {
            sortedArr = []
            for i in TasksList {
                if i.category == selectedSort {
                    sortedArr.append(i)
                }
            }
            if selectedSort == "Academic" {
                labelCategoryAcademic()
            } else if selectedSort == "Work" {
                labelCategoryWork()
            } else if selectedSort == "Personal" {
                labelCategoryPersonal()
            }
        } else if selectedSort == "Higher"{
            sortedArr = []
            labelHigherPriority()
            for i in TasksList {
                if i.priority == "High"{
                    sortedArr.append(i)
                }
            }
            for i in TasksList {
                if i.priority == "Medium"{
                    sortedArr.append(i)
                }
            }
            for i in TasksList {
                if i.priority == "Low"{
                    sortedArr.append(i)
                }
            }
        } else if selectedSort == "Lower"{
            sortedArr = []
            labelLowerPriority()
            for i in TasksList {
                if i.priority == "Low"{
                    sortedArr.append(i)
                }
            }
            for i in TasksList {
                if i.priority == "Medium"{
                    sortedArr.append(i)
                }
            }
            for i in TasksList {
                if i.priority == "High"{
                    sortedArr.append(i)
                }
            }
        } else if selectedSort == "Nearer" {
            sortedArr = nearestSort()
            labelNearerDeadline()
        } else if selectedSort == "Further" {
            labelFurtherDeadline()
            var dateSorted: [NewTasks] = [NewTasks]()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "E, d MMM y"
            
            var deadlineArr: [Date] = [Date]()
            for i in TasksList {
                let date = i.deadline
                let dateFromString = dateFormatter.date(from: date) ?? Date()
                deadlineArr.append(dateFromString)
            }
            deadlineArr = deadlineArr.sorted{$0 > $1}
            var uniqueDate: [Date] = [Date]()
            for i in deadlineArr {
                if uniqueDate.contains(i) == false {
                    uniqueDate.append(i)
                }
            }
            for i in uniqueDate {
                for j in sortedArr {
                    let date = j.deadline
                    let dateFromString = dateFormatter.date(from: date) ?? Date()
                    if i == dateFromString {
                        dateSorted.append(j)
                    }
                }
            }
            sortedArr = dateSorted
        } else if selectedSort == "Longer" {
            labelLongerTimespan()
            sortedArr = TasksList.sorted{$0.timespan > $1.timespan}
        } else if selectedSort == "Shorter" {
            labelShorterTimespan()
            sortedArr = TasksList.sorted{$0.timespan < $1.timespan}
        } else if selectedSort == "Overdue" {
            labelNewerOverdue()
            for i in TasksList{
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "E, d MMM y"
                let date = i.deadline
                let dateFromString = dateFormatter.date(from: date) ?? Date()
                if dateFromString < Date() {
                    sortedArr.append(i)
                }
            }
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        //variabel "appFont" sbg Default System Font (SF Pro Semibold 14)
        let appFont = UIFont.systemFont(ofSize: 14, weight: .semibold)
        let allAttribute: [NSAttributedString.Key: Any] = [.font: appFont, .foregroundColor: UIColor.white]
        

        //MARK: -C. SEGMENTED CONTROL
        filterSegmented.setTitleTextAttributes(allAttribute, for: .normal)
        filterSegmented.setTitleTextAttributes(allAttribute, for: .selected)
        
        //custom container for shadow
        containerFilterSegmented.layer.shadowColor = #colorLiteral(red: 0.1803921569, green: 0.1529411765, blue: 0.368627451, alpha: 1)
        containerFilterSegmented.layer.shadowOpacity = 0.45
        containerFilterSegmented.layer.shadowRadius = 5
        containerFilterSegmented.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        
        //MARK: -C. BTN SORT BY
        btnSortBy.layer.cornerRadius = 7
        //custom shadow
        btnSortBy.layer.shadowColor = #colorLiteral(red: 0.1803921569, green: 0.1529411765, blue: 0.368627451, alpha: 1)
        btnSortBy.layer.shadowOpacity = 0.5
        btnSortBy.layer.shadowRadius = 5
        btnSortBy.layer.shadowOffset = CGSize(width: 1, height: 4)


        //MARK: -C. SORT LABEL
        containerSortLabel.layer.cornerRadius = 14
        //custom container for shadow
        containerSortLabel.layer.shadowColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        containerSortLabel.layer.shadowOpacity = 0.18
        containerSortLabel.layer.shadowRadius = 8
        containerSortLabel.layer.shadowOffset = CGSize(width: 0, height: 5)
        //border
        containerSortLabel.layer.borderWidth = 0.1
        containerSortLabel.layer.borderColor = #colorLiteral(red: 0.537254902, green: 0.5098039216, blue: 0.9098039216, alpha: 1)
        
        containerSortLabel.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DispatchQueue.main.async {
            print("hello")
            self.tableView.reloadData()
        }
        if selectedSort != "" {
            sortFunction()
        }
    }
    
    //MARK: - ___ACTIONS___
    //MARK: -Action: Override Sort Label after select on modal
    //functions isi override formatting
    func labelRecommended() {
        sfSortLabel.image = UIImage(systemName: "hand.thumbsup.fill")
        sfSortLabel.tintColor = #colorLiteral(red: 0.9921568627, green: 0.3137254902, blue: 0.4705882353, alpha: 1)
        testSortLabel.text = "Recommended"
        testSortLabel.textColor = #colorLiteral(red: 0.9921568627, green: 0.3137254902, blue: 0.4705882353, alpha: 1)
        containerSortLabel.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.8274509804, blue: 0.8666666667, alpha: 1)
    }
    
    func labelCategoryAcademic() {
        sfSortLabel.image = UIImage(systemName: "graduationcap.fill")
        sfSortLabel.tintColor = UIColor.white
        sfSortLabel.alpha = 0.8
        testSortLabel.text = "Category — Academic"
        testSortLabel.textColor = UIColor.white
        testSortLabel.alpha = 0.8
        containerSortLabel.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.3137254902, blue: 0.4705882353, alpha: 1)
    }
    
    func labelCategoryWork() {
        sfSortLabel.image = UIImage(systemName: "briefcase.fill")
        sfSortLabel.tintColor = UIColor.white
        sfSortLabel.alpha = 0.8
        testSortLabel.text = "Category — Work"
        testSortLabel.textColor = UIColor.white
        testSortLabel.alpha = 0.8
        containerSortLabel.backgroundColor = #colorLiteral(red: 1, green: 0.5490196078, blue: 0.2941176471, alpha: 1)
    }
    
    func labelCategoryPersonal() {
        sfSortLabel.image = UIImage(systemName: "sparkles")
        sfSortLabel.tintColor = UIColor.white
        sfSortLabel.alpha = 0.8
        testSortLabel.text = "Category — Personal"
        testSortLabel.textColor = UIColor.white
        testSortLabel.alpha = 0.8
        containerSortLabel.backgroundColor = #colorLiteral(red: 0.537254902, green: 0.5098039216, blue: 0.9098039216, alpha: 1)
    }
    
    func labelNearerDeadline() {
        sfSortLabel.image = UIImage(systemName: "calendar.badge.exclamationmark")
        sfSortLabel.tintColor = #colorLiteral(red: 1, green: 0.5490196078, blue: 0.2941176471, alpha: 1)
        testSortLabel.text = "Nearer Deadline"
        testSortLabel.textColor = #colorLiteral(red: 1, green: 0.5490196078, blue: 0.2941176471, alpha: 1)
        containerSortLabel.backgroundColor = #colorLiteral(red: 1, green: 0.862745098, blue: 0.7882352941, alpha: 1)
    }
    
    func labelFurtherDeadline() {
        sfSortLabel.image = UIImage(systemName: "calendar.badge.exclamationmark")
        sfSortLabel.tintColor = #colorLiteral(red: 1, green: 0.5490196078, blue: 0.2941176471, alpha: 1)
        testSortLabel.text = "Further Deadline"
        testSortLabel.textColor = #colorLiteral(red: 1, green: 0.5490196078, blue: 0.2941176471, alpha: 1)
        containerSortLabel.backgroundColor = #colorLiteral(red: 1, green: 0.862745098, blue: 0.7882352941, alpha: 1)
    }
    
    func labelLongerTimespan() {
        sfSortLabel.image = UIImage(systemName: "hourglass.bottomhalf.fill")
        sfSortLabel.tintColor = #colorLiteral(red: 1, green: 0.5490196078, blue: 0.2941176471, alpha: 1)
        testSortLabel.text = "Longer Timespan"
        testSortLabel.textColor = #colorLiteral(red: 1, green: 0.5490196078, blue: 0.2941176471, alpha: 1)
        containerSortLabel.backgroundColor = #colorLiteral(red: 1, green: 0.862745098, blue: 0.7882352941, alpha: 1)
    }
    
    func labelShorterTimespan() {
        sfSortLabel.image = UIImage(systemName: "hourglass.bottomhalf.fill")
        sfSortLabel.tintColor = #colorLiteral(red: 1, green: 0.5490196078, blue: 0.2941176471, alpha: 1)
        testSortLabel.text = "Shorter Timespan"
        testSortLabel.textColor = #colorLiteral(red: 1, green: 0.5490196078, blue: 0.2941176471, alpha: 1)
        containerSortLabel.backgroundColor = #colorLiteral(red: 1, green: 0.862745098, blue: 0.7882352941, alpha: 1)
    }
    
    func labelHigherPriority() {
        sfSortLabel.image = UIImage(systemName: "exclamationmark.triangle.fill")
        sfSortLabel.tintColor = #colorLiteral(red: 0.537254902, green: 0.5098039216, blue: 0.9098039216, alpha: 1)
        testSortLabel.text = "Higher Priority"
        testSortLabel.textColor = #colorLiteral(red: 0.537254902, green: 0.5098039216, blue: 0.9098039216, alpha: 1)
        containerSortLabel.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.8509803922, blue: 0.9725490196, alpha: 1)
    }
    
    func labelLowerPriority() {
        sfSortLabel.image = UIImage(systemName: "exclamationmark.triangle.fill")
        sfSortLabel.tintColor = #colorLiteral(red: 0.537254902, green: 0.5098039216, blue: 0.9098039216, alpha: 1)
        testSortLabel.text = "Lower Priority"
        testSortLabel.textColor = #colorLiteral(red: 0.537254902, green: 0.5098039216, blue: 0.9098039216, alpha: 1)
        containerSortLabel.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.8509803922, blue: 0.9725490196, alpha: 1)
    }
    
    func labelNewerOverdue() {
        sfSortLabel.image = UIImage(systemName: "exclamationmark.arrow.circlepath")
        sfSortLabel.tintColor = #colorLiteral(red: 0.2823529412, green: 0.2823529412, blue: 0.2901960784, alpha: 1)
        testSortLabel.text = "Newer Overdue"
        testSortLabel.textColor = #colorLiteral(red: 0.2823529412, green: 0.2823529412, blue: 0.2901960784, alpha: 1)
        containerSortLabel.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.8549019608, blue: 0.8549019608, alpha: 1)
    }
    
    func labelOlderOverdue() {
        sfSortLabel.image = UIImage(systemName: "exclamationmark.arrow.circlepath")
        sfSortLabel.tintColor = #colorLiteral(red: 0.2823529412, green: 0.2823529412, blue: 0.2901960784, alpha: 1)
        testSortLabel.text = "Older Overdue"
        testSortLabel.textColor = #colorLiteral(red: 0.2823529412, green: 0.2823529412, blue: 0.2901960784, alpha: 1)
        containerSortLabel.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.8549019608, blue: 0.8549019608, alpha: 1)
    }
    
    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM y"
        return formatter.string(from: (date))
    }

    //action select sortby attribute
    @IBAction func selectRecommended(_ sender: Any) {
        labelRecommended()
    }
    
    @IBAction func selectCategoryAcademic(_ sender: Any) {
        labelCategoryAcademic()
    }
    
    @IBAction func selectCategoryWork(_ sender: Any) {
        labelCategoryWork()
    }
    
    @IBAction func selectCategoryPersonal(_ sender: Any) {
        labelCategoryPersonal()
    }
    
    @IBAction func selectNearerDeadline(_ sender: Any) {
        labelNearerDeadline()
    }
    
    @IBAction func selectFurtherDeadline(_ sender: Any) {
        labelFurtherDeadline()
    }
    
    @IBAction func selectLongerTimespan(_ sender: Any) {
        labelLongerTimespan()
    }
    
    @IBAction func selectShorterTimespan(_ sender: Any) {
        labelShorterTimespan()
    }
    
    @IBAction func selectHigherPriority(_ sender: Any) {
        labelHigherPriority()
    }
    
    @IBAction func selectLowerPriority(_ sender: Any) {
        labelLowerPriority()
    }
    
    @IBAction func selectNewerOverdue(_ sender: Any) {
        labelNewerOverdue()
    }
    
    @IBAction func selectOlderOverdue(_ sender: Any) {
        labelOlderOverdue()
    }
    
    @IBAction func segmentedValueChanged(_ sender: UISegmentedControl) {
        sortedArr = TasksList
        let currentDate = Date()
        var dateComponent = DateComponents()
        dateComponent.day = 1
        let tomorrow = Calendar.current.date(byAdding: dateComponent, to: currentDate) ?? Date()
        switch sender.selectedSegmentIndex {
        case 0:
            print("All")
            tableView.reloadData()
        case 1: do {
            var tempToday: [NewTasks] = [NewTasks]()
            print("Today")
            print(dateToString(date: currentDate))
            tempToday = sortedArr
            sortedArr = []
            for i in tempToday {
                if i.deadline == dateToString(date: currentDate){
                    sortedArr.append(i)
                }
            }
            tableView.reloadData()
        }
        case 2:
            print("Tomorrow")
            print(dateToString(date: tomorrow))
            temp = sortedArr
            sortedArr = []
            for i in temp {
                if i.deadline == dateToString(date: tomorrow){
                    sortedArr.append(i)
                }
            }
            tableView.reloadData()
        default:
            print("Index Out of Range")
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sortedArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let task = sortedArr[section]
        if task.isOpened{
            return task.subtask.count + 1
        }
        else{
            return 1
        }
        
    }
    
    func secondsToString(seconds: Double) -> String {
        let hours = Int(seconds/3600)
        let minutes = Int(seconds.truncatingRemainder(dividingBy: 3600) / 60)
        return "\(hours) Hours \(minutes) Min"
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            // Nampilin Major Task Title
            let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! customTaskTableViewController
            let fontsubtitle = UIFont.systemFont(ofSize: 14, weight: .regular)
            // ngecek ada subtask apa kagak, kalo ada baru kasih chevron
            if sortedArr[indexPath.section].subtask.count > 0 {
                cell.categoryChevron.image = UIImage(systemName: "chevron.down")
                if sortedArr[indexPath.section].isOpened == true {
                    cell.categoryChevron.image = UIImage(systemName: "chevron.up")
                } else {
                    cell.categoryChevron.image = UIImage(systemName: "chevron.down")
                }
            } else {
                cell.categoryChevron.image = nil
            }
    
            cell.taskLable.text = sortedArr[indexPath.section].name
            cell.taskLable.textColor = #colorLiteral(red: 0.1838639081, green: 0.1525175273, blue: 0.382268846, alpha: 1)
            if sortedArr[indexPath.section].deadline != "NotSet" {
                let deadline = sortedArr[indexPath.section].deadline
                let start = deadline.index(deadline.startIndex, offsetBy: 4)
                let end = deadline.index(deadline.endIndex, offsetBy: -4)
                let range = start..<end
                cell.deadlineLabel.text = String(deadline[range])
                cell.deadlineLabel.font = fontsubtitle
                cell.deadlineLabel.textColor = #colorLiteral(red: 0.5607843137, green: 0.5490196078, blue: 0.6666666667, alpha: 1)
            } else {
                cell.deadlineLabel.text = ""
            }
            if sortedArr[indexPath.section].timespan != 0 {
                cell.timespanLabel.text = secondsToString(seconds: Double(sortedArr[indexPath.section].timespan))
                cell.timespanLabel.font = fontsubtitle
                cell.timespanLabel.adjustsFontSizeToFitWidth = true
                cell.timespanLabel.textColor = #colorLiteral(red: 0.5607843137, green: 0.5490196078, blue: 0.6666666667, alpha: 1)
            } else {
                cell.timespanLabel.text = ""
            }
            
            
            if sortedArr[indexPath.section].priority != "NotSet" {
                cell.priorityLabel.text = sortedArr[indexPath.section].priority
                cell.priorityLabel.font = fontsubtitle
                cell.priorityLabel.textColor = #colorLiteral(red: 0.5607843137, green: 0.5490196078, blue: 0.6666666667, alpha: 1)
            } else {
                cell.priorityLabel.text = ""
            }
            
            if sortedArr[indexPath.section].deadline == "NotSet" && sortedArr[indexPath.section].priority == "NotSet" && sortedArr[indexPath.section].timespan == 0 {
                print("masuk")
                print(sortedArr[indexPath.section].deadline)
                print(sortedArr[indexPath.section].priority)
                print(sortedArr[indexPath.section].timespan)

                cell.taskLable.frame = CGRect(x: cell.taskLable.frame.minX, y: 18, width: cell.taskLable.frame.width, height: cell.taskLable.frame.height)
            }
            
            if sortedArr[indexPath.section].category == "Academic"{
                cell.categoryImage.image = #imageLiteral(resourceName: "Icon Academic")
            }
            else if sortedArr[indexPath.section].category == "Work"{
                cell.categoryImage.image = #imageLiteral(resourceName: "Icon Work")
            }
            else if sortedArr[indexPath.section].category == "Personal"{
                cell.categoryImage.image = #imageLiteral(resourceName: "Icon Personal")
            }
            
            return cell
        } else {
            // Nampilin subtask
            let subCell = tableView.dequeueReusableCell(withIdentifier: "customSubCell", for: indexPath)
            let font = UIFont.systemFont(ofSize: 17, weight: .semibold)
            subCell.textLabel?.font = font
            subCell.textLabel?.textColor = #colorLiteral(red: 0.1838639081, green: 0.1525175273, blue: 0.382268846, alpha: 1)
            subCell.textLabel?.text = sortedArr[indexPath.section].subtask[indexPath.row - 1]
            return subCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let task = sortedArr[indexPath.section]
        
        if task.isOpened && indexPath.row != 0{
            return 50
        }
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Code Animasi chevron
        if indexPath.row == 0 {
            sortedArr[indexPath.section].isOpened = !sortedArr[indexPath.section].isOpened
            print("tes")
        } else {
            print("Subcell")
        }
        tableView.reloadSections([indexPath.section], with: .none)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditTaskModal" {
            let navController = segue.destination as? UINavigationController
            let editModal = navController?.viewControllers.first as? NewAddNewTask
            editModal?.editMode = true
            editModal?.editTaskIndex = sender as! Int
        }
    }
    
    // MARK: - Swipe action
    // MARK: - Delete row and Done row
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, success) in
            self.performSegue(withIdentifier: "EditTaskModal", sender: indexPath.section)
            success(true)
        }
        
        let modifyAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("Update action ...")
            success(true)

            let alertView = UIAlertController(title: "Alert", message: "Are you sure you want to delete this task ? ", preferredStyle: .alert)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (alert) in
//                self.deleteItem(task: self.models[indexPath.section])
                sortedArr.remove(at: indexPath.section)
//                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadData()
                print(indexPath.section)
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
//        var task = sortedArr[indexPath.row]
        let doneAction = UIContextualAction(style: .normal, title: "Done") { (action, view, success) in
            
            success(true)
            
            let doneAlertView = UIAlertController(title: "Task Finished", message: "Congratulations you have finished a task!! 🥳", preferredStyle: .alert)
                
            let doneAlertAction = UIAlertAction(title: "Continue", style: .default) { (alert) in
//                print("Task \(indexPath.row) is DONE")
//                self.TasksList.remove(at: indexPath.row)
//                var task = self.TasksList[indexPath.row]
//                task.isDone.toggle()
//                self.TasksList[indexPath.row].isDone = true
//                self.TasksList[indexPath.section].isDone = true
                TasksList.remove(at: indexPath.section)
//                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadData()
            }
            doneAlertView.addAction(doneAlertAction)
            self.present(doneAlertView, animated: true, completion: nil)
            sortedArr.remove(at: indexPath.section)
        }
        doneAction.backgroundColor = #colorLiteral(red: 0.1838639081, green: 0.1525175273, blue: 0.382268846, alpha: 1)
        return UISwipeActionsConfiguration(actions: [doneAction])
    }
    
    func refreshTable() {
        print("reloading")
        sortedArr = TasksList
        tableView.reloadData()
    }
}


