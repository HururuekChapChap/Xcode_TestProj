//
//  File.swift
//  
//
//  Created by yoon tae soo on 2020/10/13.
//

import Foundation
import Fluent
import FluentPostgresDriver

struct CreateTestModel : Migration{
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("testSchema")
            .id()
            .field("name" , .string , .required)
            .field("job", .string) //추가한 요소
            .create()
    }
    
    //삭제하는 것
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("testSchema").delete()
    }
    
}
