//
//  NotificationCenter.swift
//  push_notification
//
//  Created by yoon tae soo on 2020/11/21.
//

import Foundation
import UserNotifications

class NotificationCenter {
    
    static let shared = NotificationCenter()
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    func userRequest() {
            
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
            
        notificationCenter.requestAuthorization(options: options) {
                (granted, error) in
                    print("granted NotificationCenter : \(granted)")
            }
    }
    
    //일반적인 알람 방법
    func generateNotification(){
        
        let content = UNMutableNotificationContent()
        
        content.title = "Hello World"
        content.body = "Main Script"
        content.sound = UNNotificationSound.default
        //화면에 보여지는 빨간색
        content.badge = 2
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let identifier = "Local Notification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let err = error {
                print(err.localizedDescription)
            }
        }
         
    }
    
    //알람을 선택 적으로 주는 방법
    func CategoryNotification(input : String){
        
        let content = UNMutableNotificationContent()
        let userActions = "User Actions"
        
        content.title = "\(input)"
        content.body = "\(input) show to you"
        content.sound = UNNotificationSound.default
        content.badge = 1
        content.categoryIdentifier = userActions
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let identifier = "Category Notification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
                   if let error = error {
                       print("Error \(error.localizedDescription)")
                   }
               }
               
        let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze", options: [])
        let deleteAction = UNNotificationAction(identifier: "Delete", title: "Delete", options: [.destructive])
        let category = UNNotificationCategory(identifier: userActions,
                                                     actions: [snoozeAction, deleteAction],
                                                     intentIdentifiers: [],
                                                     options: [])
        
        notificationCenter.setNotificationCategories([category])
        
    }
    
}
