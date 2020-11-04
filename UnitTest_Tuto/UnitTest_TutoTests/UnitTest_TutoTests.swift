//
//  UnitTest_TutoTests.swift
//  UnitTest_TutoTests
//
//  Created by yoon tae soo on 2020/11/04.
//

import XCTest
//Main 폴더를 import 해줘야 한다.
@testable import UnitTest_Tuto

class UnitTest_TutoTests: XCTestCase {
        
    var test : Calculater!
    
    //This is Like Unit Test ViewDidLoad
    override func setUp() {
        super.setUp()
        test = Calculater()
        
    }
    
    //Clean up all the test
    override func tearDown() {
        super.tearDown()
        test = nil
    }
    
    //에러를 반환안하면 Okey
    func test_plus_Correct() {
        
        XCTAssertNoThrow(try test.plus(10, 2))

    }
    
    //에러를 반환 했을 때 확인 하는 방법
    func test_plus_small(){
        let errorMessage = ErrorHandler.isEmpty
        var error : ErrorHandler?
        
        XCTAssertThrowsError(try test.plus(nil, 10)){ result in
                
            error = result as? ErrorHandler
        }
        
        XCTAssertEqual(error, errorMessage)
        
    }
    
    //여러개를 테스트 하는 과정
    func test_by_input(){
        
        let errorMessage = ErrorHandler.overNumber
        var error : ErrorHandler?
        
        let inputOne : Int? = 10
        let inputTwo : Int? = 30
        
        
        //XCTUnwrap은 nil 값이 있는지 없는지 확인
        XCTAssertNoThrow(try XCTUnwrap(inputOne))
        
        //nil인지 아닌지 확인
        XCTAssertNotEqual(inputOne, nil)
//        XCTAssertEqual(inputTwo, nil)
        
        XCTAssertThrowsError(try test.plus(inputOne, inputTwo)){ result in
            error = result as? ErrorHandler
        }
        
        XCTAssertEqual(error, errorMessage)
        
    }
    

}
