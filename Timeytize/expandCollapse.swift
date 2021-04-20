//
//  expandCollapse.swift
//  Timeytize
//
//  Created by Peter Lee on 10/04/21.
//

import UIKit

class Section {
    let title: String
    let options: [String]
    var isOpened: Bool = false
    
    init(title: String, options: [String], isOpened: Bool = false) {
        self.title = title
        self.options = options
        self.isOpened = isOpened
    }
}

class testtableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    var sections = [Section]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sections = [
            Section(title: "Task Name", options: ["Tes"].compactMap({ return "\($0)"})),
            Section(title: "Category", options: ["Academic", "Work", "Personal", "None"].compactMap({ return "\($0)"})),
            Section(title: "Priority", options: ["High", "Medium", "Low", "None"].compactMap({ return "\($0)"})),
            Section(title: "Deadline", options: ["Calendar"].compactMap({ return "\($0)"})),
            Section(title: "Time Span", options: ["Count Down Timer"].compactMap({ return "\($0)"})),
            Section(title: "Subtask", options: ["Subtasks-"].compactMap({ return "\($0)"})),
        ]
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        if section.isOpened {
            return section.options.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if indexPath.row == 0 {
            // Section Title
            cell.textLabel?.text = sections[indexPath.section].title
            
        } else {
            // Section Subcells
            cell.textLabel?.text = sections[indexPath.section].options[indexPath.row - 1]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let section = indexPath.section
        let row = indexPath.row
        print(section)
        print(row)
        if indexPath.row == 0 {
            sections[indexPath.section].isOpened = !sections[indexPath.section].isOpened
            tableView.reloadSections([indexPath.section], with: .none)
        } else {
            print("subcell")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
