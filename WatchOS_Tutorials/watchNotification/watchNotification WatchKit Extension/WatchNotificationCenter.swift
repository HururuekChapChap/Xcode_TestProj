//
//  WatchNotificationCenter.swift
//  watchNotification WatchKit Extension
//
//  Created by yoon tae soo on 2021/03/01.
//

import Foundation
import UserNotifications

class WatchNotificationCenter{
    
    static let shared = WatchNotificationCenter()
    
    let notification = UNUserNotificationCenter.current()
    
    func generateNotification(){
        
        let content = UNMutableNotificationContent()
        
        content.title = "Hello world"
        content.body = "Main Script"
        content.subtitle = "Subtitle"
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "Action"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let identifier = "Local"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notification.add(request) { (err) in
            if let err = err{
                print("error occured in add : \(err.localizedDescription)")
            }
            else{
                print("WatchOS Generate Notification")
            }
        }
        
    }
    
    func present(){
        
        print("Shared work!!!")
        
    }
    
}
