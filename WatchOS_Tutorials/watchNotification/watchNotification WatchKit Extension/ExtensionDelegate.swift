//
//  ExtensionDelegate.swift
//  watchNotification WatchKit Extension
//
//  Created by yoon tae soo on 2021/03/01.
//

import WatchKit
import UserNotifications

class ExtensionDelegate: NSObject, WKExtensionDelegate {

    let notification = WatchNotificationCenter.shared.notification
    let test = WatchNotificationCenter.shared
    
    func applicationDidFinishLaunching() {
        // Perform any final initialization of your application.
        print("watch application Did Finish Launching")
        
        let options : UNAuthorizationOptions = [.alert,.sound]
        
        notification.requestAuthorization(options: options) { (granted , error) in
            
            if error == nil {
                print("granted NotificationCenter : \(granted)")
                self.setUNUserNotificationDelegate()
                
                // Snooze Action 추가
                let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze", options: [.foreground])
               // Delete Action 추가 wiht 빨간색 .destructive
               let deleteAction = UNNotificationAction(identifier: "Delete", title: "Delete", options: [.destructive])
               
               // 카테고리 서류 작성
               let category = UNNotificationCategory(identifier: "Action",
                                                            actions: [snoozeAction, deleteAction],
                                                            intentIdentifiers: [],
                                                            options: [])
               // 카테고리 등록
                self.notification.setNotificationCategories([category])
                
            }
            else{
                print("Error Occured in Autorization : \(error!.localizedDescription)")
            }
            
        }
        
    }

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
        for task in backgroundTasks {
            // Use a switch statement to check the task type
            switch task {
            case let backgroundTask as WKApplicationRefreshBackgroundTask:
                // Be sure to complete the background task once you’re done.
                backgroundTask.setTaskCompletedWithSnapshot(false)
            case let snapshotTask as WKSnapshotRefreshBackgroundTask:
                // Snapshot tasks have a unique completion call, make sure to set your expiration date
                snapshotTask.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: Date.distantFuture, userInfo: nil)
            case let connectivityTask as WKWatchConnectivityRefreshBackgroundTask:
                // Be sure to complete the connectivity task once you’re done.
                connectivityTask.setTaskCompletedWithSnapshot(false)
            case let urlSessionTask as WKURLSessionRefreshBackgroundTask:
                // Be sure to complete the URL session task once you’re done.
                urlSessionTask.setTaskCompletedWithSnapshot(false)
            case let relevantShortcutTask as WKRelevantShortcutRefreshBackgroundTask:
                // Be sure to complete the relevant-shortcut task once you're done.
                relevantShortcutTask.setTaskCompletedWithSnapshot(false)
            case let intentDidRunTask as WKIntentDidRunRefreshBackgroundTask:
                // Be sure to complete the intent-did-run task once you're done.
                intentDidRunTask.setTaskCompletedWithSnapshot(false)
            default:
                // make sure to complete unhandled task types
                task.setTaskCompletedWithSnapshot(false)
            }
        }
    }

}


extension ExtensionDelegate : UNUserNotificationCenterDelegate{
    
    func setUNUserNotificationDelegate(){
        notification.delegate = self
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.banner,.sound])
        
    }
    
    //눌렀을 때, 특정한 활동을 수행 할 수 있도록 하기
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        //actionIdentifier에서는 화면 전환을 어떻게 하는지 잘 모르겠다.
        switch response.actionIdentifier {
            case UNNotificationDismissActionIdentifier:
                    print("Dismiss Action")
            case UNNotificationDefaultActionIdentifier:
                    print("Default")
            case "Snooze":
                    print("Snooze")
//                test.present()
                if let IC = WKExtension.shared().rootInterfaceController as? InterfaceController{
                    
                    print("IC Exist")
                    
                    IC.pushController(withName: "Second", context: nil)
                    
                    
                }
        
        
            case "Delete":
                    print("Delete")
            default:
                    print("Unknown action")
        }
        
        
        completionHandler()
        
    }
    
}
