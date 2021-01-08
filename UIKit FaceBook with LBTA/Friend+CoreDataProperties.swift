//
//  Friend+CoreDataProperties.swift
//  UIKit FaceBook with LBTA
//
//  Created by yoon tae soo on 2021/01/08.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var name: String?
    @NSManaged public var chat_message: NSSet?

}

// MARK: Generated accessors for chat_message
extension Friend {

    @objc(addChat_messageObject:)
    @NSManaged public func addToChat_message(_ value: Message)

    @objc(removeChat_messageObject:)
    @NSManaged public func removeFromChat_message(_ value: Message)

    @objc(addChat_message:)
    @NSManaged public func addToChat_message(_ values: NSSet)

    @objc(removeChat_message:)
    @NSManaged public func removeFromChat_message(_ values: NSSet)

}

extension Friend : Identifiable {

}
