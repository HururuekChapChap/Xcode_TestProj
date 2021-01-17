//
//  ViewController.m
//  TabBarController_no_StoryBoard_Obj-c
//
//  Created by yoon tae soo on 2021/01/17.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (id) initWithParams:(NSString *)title bgColor:(UIColor *)bgColor {
    
    self.title = title;
    self.view.backgroundColor = bgColor;
    
    return self;
}


@end
