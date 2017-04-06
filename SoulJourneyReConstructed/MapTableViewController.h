//
//  MapTableViewController.h
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/30.
//  Copyright © 2017年 CH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineModel.h"
#import "MapSectionHeaderView.h"

@interface MapTableViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *joinTrackBtn;

@property NSString *photoUrl;
@property LineModel *model;

- (void)showFromTracks:(NSString *)id;

@end
