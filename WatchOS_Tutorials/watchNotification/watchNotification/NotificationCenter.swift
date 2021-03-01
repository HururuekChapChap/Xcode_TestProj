//
//  NotificationCenter.swift
//  watchNotification
//
//  Created by yoon tae soo on 2021/03/01.
//

import Foundation
import UserNotifications

class NotificationCenter {
    
    static let shared = NotificationCenter()
    
    let notificationCenter = UNUserNotificationCenter.current()
    
//    func userRequest(application : UIApplication){
//
//        let options : UNAuthorizationOptions = [.alert,.sound,.badge]
//        
//        notificationCenter.requestAuthorization(options: options) { (granted , error) in
//
//            if error == nil {
//                print("granted NotificationCenter : \(granted)")
//
//                DispatchQueue.main.async(execute: { application.registerForRemoteNotifications() })
//
//            }
//            else{
//                print("Error Occured in Autorization : \(error!.localizedDescription)")
//            }
//
//        }
//
//    }
    
    func generateNotification(){
        
        let content = UNMutableNotificationContent()
        
        content.title = "Hello world"
        content.body = "Main Script"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let identifier = "Local"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.add(request) { (err) in
            if let err = err{
                print("error occured in add : \(err.localizedDescription)")
            }
            else{
                print("add success")
            }
        }
        
    }
    
}
