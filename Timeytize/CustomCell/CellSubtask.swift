//
//  CellSubtask.swift
//  Timeytize-2
//
//  Created by Nico Christian on 08/04/21.
//

import Foundation
import UIKit

class CellSubtask: UITableViewCell {
    @IBOutlet weak var subtaskTextField: UITextField!
    @IBAction func subtaskValueChanged(_ sender: UITextField) {
        print("subtask typed!")
    }
}
