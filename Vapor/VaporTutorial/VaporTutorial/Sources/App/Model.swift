//
//  File.swift
//  
//
//  Created by yoon tae soo on 2020/10/11.
//

import Foundation
import Vapor

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
