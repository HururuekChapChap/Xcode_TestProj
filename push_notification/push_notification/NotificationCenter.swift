//
//  NotificationCenter.swift
//  push_notification
//
//  Created by yoon tae soo on 2020/11/21.
//

import Foundation
import UserNotifications

class NotificationCenter {
    
    static let notificationCenter = UNUserNotificationCenter.current()
    
    func userRequest() {
            
            let options: UNAuthorizationOptions = [.alert, .sound, .badge]
            
        NotificationCenter.notificationCenter.requestAuthorization(options: options) {
                (didAllow, error) in
                if !didAllow {
                    print("User has declined notifications")
                }
            }
    }
    
}
