//
//  Message+CoreDataProperties.swift
//  UIKit FaceBook with LBTA
//
//  Created by yoon tae soo on 2020/12/28.
//
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var detail: String?
    @NSManaged public var date: Date?
    @NSManaged public var chat_friend: Friend?

}

extension Message : Identifiable {

}
