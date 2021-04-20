//
//  CellTimeSpan.swift
//  Timeytize-2
//
//  Created by Nico Christian on 08/04/21.
//

import Foundation
import UIKit

class CellTimeSpan: UITableViewCell {
    @IBOutlet weak var timeSpanDatePicker: UIDatePicker!
    var seconds: Double = 0.0
    
    @IBAction func timeSpanValueChanged(_ sender: UIDatePicker) {
        seconds = sender.countDownDuration
    }
}
