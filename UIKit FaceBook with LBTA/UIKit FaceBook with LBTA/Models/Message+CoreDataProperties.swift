//
//  Message+CoreDataProperties.swift
//  UIKit FaceBook with LBTA
//
//  Created by yoon tae soo on 2021/01/11.
//
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var date: Date?
    @NSManaged public var detail: String?
    @NSManaged public var isSender: Bool
    @NSManaged public var chat_friend: Friend?
    @NSManaged public var friend_entity: Friend?

}

extension Message : Identifiable {

}
