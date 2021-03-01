//
//  AppDelegate.swift
//  watchNotification
//
//  Created by yoon tae soo on 2021/03/01.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let notification = NotificationCenter.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        let options : UNAuthorizationOptions = [.alert,.sound,.badge]
        
        notification.notificationCenter.requestAuthorization(options: options) { (granted , error) in
            
            if error == nil {
                print("granted NotificationCenter : \(granted)")
                
                DispatchQueue.main.async(execute: { application.registerForRemoteNotifications() })
                
            }
            else{
                print("Error Occured in Autorization : \(error!.localizedDescription)")
            }
            
        }
        
        setUNUserNotificationDelegate()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate : UNUserNotificationCenterDelegate {
    
    func setUNUserNotificationDelegate(){
        notification.notificationCenter.delegate = self
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.banner,.sound,.badge])
        
    }
    
    // For handling tap and user actions
        func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

            switch response.actionIdentifier {
            case "action1":
                print("Action First Tapped")
            case "action2":
                print("Action Second Tapped")
            default:
                break
            }
            completionHandler()
        }
    
 }

