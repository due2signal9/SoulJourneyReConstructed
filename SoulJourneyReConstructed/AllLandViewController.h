//
//  AllLandViewController.h
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/18.
//  Copyright © 2017年 CH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeListModel.h"

@interface AllLandViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>


- (void)modelSetUp: (NSMutableArray *)model;
- (void)getData : (NSString *)region;

@end
