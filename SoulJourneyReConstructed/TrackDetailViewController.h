//
//  TrackDetailViewController.h
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/4/4.
//  Copyright © 2017年 CH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrackModel.h"
#import <MWPhotoBrowser.h>

@interface TrackDetailViewController : UIViewController <MWPhotoBrowserDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (void)modelSetUp: (TrackModel *)model;

@end
