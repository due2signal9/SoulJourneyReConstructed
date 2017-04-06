//
//  MyTabBarController.m
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/14.
//  Copyright © 2017年 CH. All rights reserved.
//

#import "MyTabBarController.h"
#import "HomeViewController.h"
#import "TrackViewController.h"
#import "ScheduleViewController.h"
#import "MineViewController.h"

@interface MyTabBarController ()

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createViewControllers];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createViewControllers {
    
    NSArray *titles = [NSArray arrayWithObjects:@"首页", @"足迹", @"行程", @"我的", nil];
    NSArray *images = [NSArray arrayWithObjects:@"shouye.png", @"zuji1.png", @"xingcheng2.png", @"wo.png", nil];
    NSArray *images_selected = [NSArray arrayWithObjects:@"shouye_selected.png", @"zuji1_selected.png", @"xingcheng2_selected.png", @"wo_selected.png", nil];
    
    HomeViewController *homeViewController = [[HomeViewController alloc] init];
    UINavigationController *homeNavigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    
    TrackViewController *trackViewController = [[TrackViewController alloc] init];
    UINavigationController *trackNavigationController = [[UINavigationController alloc] initWithRootViewController:trackViewController];
    
    ScheduleViewController *scheduleViewController = [[ScheduleViewController alloc] init];
    UINavigationController *scheduleNavigationController = [[UINavigationController alloc] initWithRootViewController:scheduleViewController];
    
    MineViewController *mineViewController = [[MineViewController alloc] init];
    UINavigationController *mineNavigationController = [[UINavigationController alloc] initWithRootViewController:mineViewController];
    
    NSArray *VCs = @[homeViewController, trackViewController, scheduleViewController, mineViewController];
    NSArray *navigations = @[homeNavigationController, trackNavigationController, scheduleNavigationController, mineNavigationController];

    for (int i = 0; i < titles.count; i++) {
        
        ((UINavigationController *)navigations[i]).tabBarItem.title = titles[i];
        ((UINavigationController *)navigations[i]).tabBarItem.image = [[UIImage imageNamed:images[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        ((UINavigationController *)navigations[i]).tabBarItem.selectedImage = [[UIImage imageNamed:images_selected[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        ((UIViewController *)VCs[i]).navigationItem.title = titles[i];
        
    }
    
    self.viewControllers = navigations;
    NSLog(@"MyTabBarController/<createViewControllers> DONE...");
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
