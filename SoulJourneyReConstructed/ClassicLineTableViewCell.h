//
//  ClassicLineTableViewCell.h
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/18.
//  Copyright © 2017年 CH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineModel.h"

@interface ClassicLineTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *daysLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;

- (void)modelSetUp: (LineModel *)model;

@end
