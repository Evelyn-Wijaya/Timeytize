//
//  customTaskTableViewController.swift
//  Timeytize
//
//  Created by Rahmannur Rizki Syahputra on 10/04/21.
//

import UIKit

class customTaskTableViewController: UITableViewCell {
//    ini outlet yang nyambung ke cell nya task
    
    @IBOutlet weak var taskLable:UILabel!
    @IBOutlet weak var deadlineLabel:UILabel!
    @IBOutlet weak var timespanLabel:UILabel!
    @IBOutlet weak var priorityLabel:UILabel!
    @IBOutlet weak var categoryImage:UIImageView!
    @IBOutlet weak var categoryChevron: UIImageView!
    
}
