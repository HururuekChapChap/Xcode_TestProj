//
//  File.swift
//  
//
//  Created by yoon tae soo on 2020/10/15.
//

import Foundation
import Fluent
import FluentPostgresDriver

struct CreateUserModel : Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        
        database.schema("user")
            .id()
            .field("status", .string)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("user").delete()
    }
    
}
