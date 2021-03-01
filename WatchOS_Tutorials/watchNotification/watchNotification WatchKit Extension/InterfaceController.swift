//
//  InterfaceController.swift
//  watchNotification WatchKit Extension
//
//  Created by yoon tae soo on 2021/03/01.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    let notification = WatchNotificationCenter.shared
    
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }

    @IBAction func startNotification() {
        
        notification.generateNotification()
        
    }
}
