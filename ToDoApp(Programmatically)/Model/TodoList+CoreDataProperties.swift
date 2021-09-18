//
//  TodoList+CoreDataProperties.swift
//  ToDoApp(Programmatically)
//
//
//

import Foundation
import CoreData


extension TodoList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoList> {
        return NSFetchRequest<TodoList>(entityName: "TodoList")
    }

    @NSManaged public var title: String?
    @NSManaged public var describe: String?
    @NSManaged public var importance: String?

}

extension TodoList : Identifiable {

}
