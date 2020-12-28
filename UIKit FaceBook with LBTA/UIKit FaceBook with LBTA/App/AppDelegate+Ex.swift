//
//  AppDelegate+Ex.swift
//  UIKit FaceBook with LBTA
//
//  Created by yoon tae soo on 2020/12/27.
//

import UIKit
import CoreData

extension AppDelegate {
    
  // MARK: - Core Data Saving support

  func saveContext () {
      let context = persistentContainer.viewContext
      if context.hasChanges {
          do {
              try context.save()
          } catch {
              // Replace this implementation with code to handle the error appropriately.
              // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
              let nserror = error as NSError
              fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
          }
      }
  }
    
}
