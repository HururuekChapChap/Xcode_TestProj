//
//  SecondInterfaceController.swift
//  Grocery List Watch Extension
//
//  Created by yoon tae soo on 2021/02/20.
//

import WatchKit
import Foundation


class SecondInterfaceController: WKInterfaceController {
    
    @IBOutlet var itemLabel : WKInterfaceLabel!

    //Save Data
    let userDefualts = UserDefaults()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
        self.itemLabel.setText(userDefualts.value(forKey: "item") as? String ?? "")
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func addButtonTapped(){
        
        self.presentTextInputController(withSuggestions: nil, allowedInputMode: .allowEmoji) { (results) in
            
            guard let resultList = results else {return}
            
            DispatchQueue.main.async {
                self.dismissTextInputController()
                self.itemLabel.setText(resultList[0] as? String)
                self.userDefualts.setValue(resultList[0] as? String, forKey: "item")
            }
            
        }
        
    }

}
