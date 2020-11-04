//
//  Calculater.swift
//  UnitTest_Tuto
//
//  Created by yoon tae soo on 2020/11/04.
//

import Foundation


enum ErrorHandler : String , Error{
    
    case isEmpty = "데이터가 비어있다."
    case overNumber = "숫자가 너무 크다"
    case smallNumber = "숫자가 너무 작다"
}

struct Calculater{
    
    func plus(_ input1 : Int? , _ input2 : Int?) throws -> Int{
        
        guard let one = input1 , let two = input2 else {throw ErrorHandler.isEmpty}
        
        
        let sum = one + two
        
        if sum > 30 {
            throw ErrorHandler.overNumber
        }
        else if sum < 10 {
            throw ErrorHandler.smallNumber
        }
        
        return one + two
        
    }
    
}
