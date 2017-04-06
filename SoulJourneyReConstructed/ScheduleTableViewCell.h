//
//  ScheduleTableViewCell.h
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/4/3.
//  Copyright © 2017年 CH. All rights reserved.
//

#import "TrackLineModel.h"
#import <UIKit/UIKit.h>

@interface ScheduleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dayCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *mainTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

- (void)modelSetUp:(TrackLineModel *)model;

@end
