//
//  MainTabBarViewController.m
//  TabBarController_no_StoryBoard_Obj-c
//
//  Created by yoon tae soo on 2021/01/17.
//

#import "MainTabBarViewController.h"
#import "ViewController.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"Mian TabBarContoller - viewDidLoad() called");
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    ViewController * firstView = [ ViewController.new initWithParams:@"첫번째" bgColor:[UIColor redColor]];
    ViewController * secondView = [ ViewController.new initWithParams:@"두번째" bgColor:[UIColor greenColor]];
    ViewController * thridView = [ ViewController.new initWithParams:@"세번째" bgColor:[UIColor blueColor]];
    ViewController * forthView = [ ViewController.new initWithParams:@"네번째" bgColor:[UIColor yellowColor]];
    
    
    UINavigationController * firstVC = [UINavigationController.new initWithRootViewController: firstView];
    UINavigationController * secondVC = [UINavigationController.new initWithRootViewController: secondView];
    UINavigationController * thirdVC = [UINavigationController.new initWithRootViewController: thridView];
    UINavigationController * forthVC = [UINavigationController.new initWithRootViewController: forthView];
    
    NSMutableArray * ncArray = [NSMutableArray array];
    
    UITabBarItem * firstTabBarItem = [UITabBarItem.new initWithTitle:@"firstVC" image:[UIImage systemImageNamed:@"folder.fill"] tag:0];
    UITabBarItem * secondTabBarItem = [UITabBarItem.new initWithTitle:@"secondVC" image:[UIImage systemImageNamed:@"folder.fill"] tag:1];
    UITabBarItem * thirdTabBarItem = [UITabBarItem.new initWithTitle:@"thirdVC" image:[UIImage systemImageNamed:@"folder.fill"] tag:2];
    UITabBarItem * forthTabBarItem = [UITabBarItem.new initWithTitle:@"forthVC" image:[UIImage systemImageNamed:@"folder.fill"] tag:3];
    
    firstVC.tabBarItem = firstTabBarItem;
    secondVC.tabBarItem = secondTabBarItem;
    thirdVC.tabBarItem = thirdTabBarItem;
    forthVC.tabBarItem = forthTabBarItem;
    
    [ncArray addObject:firstVC];
    [ncArray addObject:secondVC];
    [ncArray addObject:thirdVC];
    [ncArray addObject:forthVC];
    
    
    self.viewControllers = ncArray;
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
