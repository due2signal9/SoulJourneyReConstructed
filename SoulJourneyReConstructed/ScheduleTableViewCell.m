//
//  ScheduleTableViewCell.m
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/4/3.
//  Copyright © 2017年 CH. All rights reserved.
//

#import "ScheduleTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ScheduleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)modelSetUp:(TrackLineModel *)model {
    
    self.dateLabel.text = model.date;
    self.dayCountLabel.text = [NSString stringWithFormat:@"%ld天", model.daycount];
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.photo_url] placeholderImage:nil];
    self.mainTitleLabel.text = model.title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
