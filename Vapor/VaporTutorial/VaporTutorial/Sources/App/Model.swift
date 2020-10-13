//
//  File.swift
//  
//
//  Created by yoon tae soo on 2020/10/11.
//

import Foundation
import Vapor
import FluentSQLiteDriver

struct CupCake : Content {
    
    let id : Int?
    let name : String
    let description : String
    let price : Int
    
}

struct Context: Content {
    var name : String
    var items : [CupCake]
       }


final class TestModel : Model , Content {
    
    
    static let schema: String = "testSchema"
    
    @ID(key: .id)
    var id : UUID?
    
    @Field(key: "name")
    var name : String
    
    //새롭게 추가 - 새롭게 추가하기 위해서는 revert를 해줘야한다.
    @Field(key: "job")
    var job : String
    
    init(){}
    
    init(id : UUID? = nil , name : String, job : String) {
        self.id = id
        self.name = name
        self.job = job
    }
    
}


