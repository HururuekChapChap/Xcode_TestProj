//
//  AppDelegate.swift
//  push_notification
//
//  Created by yoon tae soo on 2020/11/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let notification = NotificationCenter.shared
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        notification.userRequest()
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
    
    //뱃지 초기화 시키는 방법 IOS 13 이하
    func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0;
    }


}

extension AppDelegate : UNUserNotificationCenterDelegate {
    
    func setUNUserNotificationDelegate(){
        notification.notificationCenter.delegate = self
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.list,.sound,.banner])
        
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        guard let rootViewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController else {
               return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        if response.notification.request.identifier == "Local Notification" {
            print("Hello Local Notification")
            
            if  let secondVC = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController,
                   let navController = rootViewController as? UINavigationController{

                navController.pushViewController(secondVC, animated: true)
                
            }
            
        }
        
        //actionIdentifier에서는 화면 전환을 어떻게 하는지 잘 모르겠다.
        switch response.actionIdentifier {
            case UNNotificationDismissActionIdentifier:
                    print("Dismiss Action")
            case UNNotificationDefaultActionIdentifier:
                    print("Default")
            case "Snooze":
                    print("Snooze")
                
            case "Delete":
                    print("Delete")
            default:
                    print("Unknown action")
        }
        
        
        completionHandler()
        
    }
    
}

