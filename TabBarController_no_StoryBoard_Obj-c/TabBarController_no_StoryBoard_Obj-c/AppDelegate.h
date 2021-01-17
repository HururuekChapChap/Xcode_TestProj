//
//  AppDelegate.h
//  TabBarController_no_StoryBoard_Obj-c
//
//  Created by yoon tae soo on 2021/01/17.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

