//
//  File.swift
//  
//
//  Created by yoon tae soo on 2020/10/25.
//

import Foundation
import Fluent
import FluentPostgresDriver

struct CreateCupCakeModel : Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        
        database.schema("CupCake")
            .id()
            .field("name", .string)
            .field("description", .string)
            .field("price", .int)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("CupCake").delete()
    }
    
}
