//
//  InterfaceController.swift
//  Grocery List Watch Extension
//
//  Created by yoon tae soo on 2021/02/20.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    @IBOutlet var myButton : WKInterfaceButton!
    
    
    @IBOutlet var myTable : WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
        
        let array = ["Apples", "Oranges", "Grapes", "Bananase","Mangos"]
        
        //how many cell will show
        myTable.setNumberOfRows(5, withRowType: "Cell")
        
        //Create Table label
        for (index, fruit) in array.enumerated() {
            guard let row = myTable.rowController(at: index) as? RowController else {continue}
            
            row.myLabel.setText(fruit)
            
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }

    @IBAction func buttonTapped(){
        
        myButton.setTitle("Tapped")
        
    }
    
}
