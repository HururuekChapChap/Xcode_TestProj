//
//  Person+CoreDataProperties.swift
//  CoreData_Tuto
//
//  Created by yoon tae soo on 2020/12/26.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var age: String?
    @NSManaged public var birth: Date?
    @NSManaged public var name: String?
    @NSManaged public var todoList: NSSet?

}

// MARK: Generated accessors for todoList
extension Person {

    @objc(addTodoListObject:)
    @NSManaged public func addToTodoList(_ value: Todo)

    @objc(removeTodoListObject:)
    @NSManaged public func removeFromTodoList(_ value: Todo)

    @objc(addTodoList:)
    @NSManaged public func addToTodoList(_ values: NSSet)

    @objc(removeTodoList:)
    @NSManaged public func removeFromTodoList(_ values: NSSet)

}

extension Person : Identifiable {

}
