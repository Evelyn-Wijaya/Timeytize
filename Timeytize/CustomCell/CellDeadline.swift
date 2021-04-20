//
//  CellDeadline.swift
//  Timeytize-2
//
//  Created by Nico Christian on 08/04/21.
//

import Foundation
import UIKit

class CellDeadline: UITableViewCell {
    @IBOutlet weak var deadlineDatePicker: UIDatePicker!
    var newValue: Date = Date()
    
    @IBAction func deadlineValueChanged(_ sender: UIDatePicker) {
        newValue = sender.date
        let formatter = DateFormatter()
        formatter.dateFormat = "E d MMM y"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
