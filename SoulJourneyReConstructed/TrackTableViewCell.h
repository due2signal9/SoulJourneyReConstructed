//
//  TrackTableViewCell.h
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/4/4.
//  Copyright © 2017年 CH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrackModel.h"

@interface TrackTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *mainTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *actorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

- (void)modelSetUp: (TrackModel *)model;

@end
