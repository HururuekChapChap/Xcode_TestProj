//
//  HttpReqeustTest.swift
//  UnitTest_TutoTests
//
//  Created by yoon tae soo on 2020/11/05.
//

import XCTest
@testable import UnitTest_Tuto

class HttpReqeustTest: XCTestCase {

    var httpRequest : HttpRequest?
    
    override func setUp() {
        super.setUp()
        httpRequest = HttpRequest()
    }
    
    override func tearDown() {
        httpRequest = nil
        super.tearDown()
    }
    
    func test_HttpRequest(){
        
        let expectation = self.expectation(description: "성공적으로 일을 마침")
        
        let url = httpRequest?.makeUrl(url: "http://localhost:8080/hello/vapor")
        
        httpRequest?.getInfoData(url: url, completeHandler: { (result) in
            
            switch result {
            
            case .success(let infos):
                
                XCTAssertNotNil(infos)
                expectation.fulfill()
                
            case .failure(let error):
                XCTFail(error.rawValue)
            }
            
            
        })
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
        
        
    }

}
