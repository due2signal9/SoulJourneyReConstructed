//
//  LandsCollectionViewCell.m
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/18.
//  Copyright © 2017年 CH. All rights reserved.
//

#import "LandsCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation LandsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)modelSetUp:(HomeListModel *)model {
    
    self.subNameLabel.text = [model valueForKey:@"name_en"];
    self.nameLabel.text = [model valueForKey:@"name"];
    
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:[[model valueForKey:@"photo"] valueForKey:@"photo_url"]] placeholderImage:nil];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.coverImageView.layer.masksToBounds = YES;
    self.coverImageView.layer.cornerRadius = 5;
}

@end
