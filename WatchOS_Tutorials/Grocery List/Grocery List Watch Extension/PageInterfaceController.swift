//
//  PageInterfaceController.swift
//  Grocery List Watch Extension
//
//  Created by yoon tae soo on 2021/02/20.
//

import WatchKit
import Foundation


class PageInterfaceController: WKInterfaceController {
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    //각각의 Interface의 Identifier에 이름을 넣어주고
    //withName에 그 이름을 넣어주면 끝!
    @IBAction func firstScreenTapped(){
     
        self.pushController(withName: "First", context: nil)
        
    }
    
    @IBAction func SecondScreenTapped(){
        
        self.pushController(withName: "Second", context: nil)
    }
    
    @IBAction func ThirdScreenTapped(){
        self.pushController(withName: "Third", context: nil)
    }
    

}
