//
//  TrackTableViewCell.m
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/4/4.
//  Copyright © 2017年 CH. All rights reserved.
//

#import "TrackTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation TrackTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)modelSetUp:(TrackModel *)model {
    
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:[model.contents[0] valueForKey:@"photo_url"]] placeholderImage:nil];
    self.actorNameLabel.text = model.user.name;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[model.user valueForKey:@"photo_url"]] placeholderImage:nil];
    
    self.dateLabel.text = model.created_at;
    self.mainTitleLabel.text = model.topic;
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.cornerRadius = 20;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
