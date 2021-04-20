//
//  Subtask+CoreDataProperties.swift
//  Timeytize
//
//  Created by Peter Lee on 13/04/21.
//
//

import Foundation
import CoreData


extension Subtask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Subtask> {
        return NSFetchRequest<Subtask>(entityName: "Subtask")
    }

    @NSManaged public var name: String?
    @NSManaged public var task: Task?

}

extension Subtask : Identifiable {

}
