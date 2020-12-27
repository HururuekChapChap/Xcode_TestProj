//
//  Todo+CoreDataProperties.swift
//  CoreData_Tuto
//
//  Created by yoon tae soo on 2020/12/26.
//
//

import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var name: String?
    @NSManaged public var master: Person?

}

extension Todo : Identifiable {

}
