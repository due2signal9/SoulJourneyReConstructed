//
//  HomeViewController.h
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/14.
//  Copyright © 2017年 CH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

@interface HomeViewController : UIViewController<AMapLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource>

@end
