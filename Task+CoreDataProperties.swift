//
//  Task+CoreDataProperties.swift
//  Timeytize
//
//  Created by Peter Lee on 13/04/21.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var category: String?
    @NSManaged public var deadline: Date?
    @NSManaged public var done: Bool
    @NSManaged public var isOpened: Bool
    @NSManaged public var name: String?
    @NSManaged public var priority: String?
    @NSManaged public var timespan: Int64
    @NSManaged public var subtasks: NSSet?

}

// MARK: Generated accessors for subtasks
extension Task {

    @objc(addSubtasksObject:)
    @NSManaged public func addToSubtasks(_ value: Subtask)

    @objc(removeSubtasksObject:)
    @NSManaged public func removeFromSubtasks(_ value: Subtask)

    @objc(addSubtasks:)
    @NSManaged public func addToSubtasks(_ values: NSSet)

    @objc(removeSubtasks:)
    @NSManaged public func removeFromSubtasks(_ values: NSSet)

}

extension Task : Identifiable {

}
