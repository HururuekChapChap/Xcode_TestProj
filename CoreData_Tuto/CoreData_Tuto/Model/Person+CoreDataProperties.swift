//
//  Person+CoreDataProperties.swift
//  CoreData_Tuto
//
//  Created by yoon tae soo on 2020/12/25.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: String?
    @NSManaged public var birth: Date?

}

extension Person : Identifiable {

}
