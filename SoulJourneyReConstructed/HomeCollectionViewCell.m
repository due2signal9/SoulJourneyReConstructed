//
//  HomeCollectionViewCell.m
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/16.
//  Copyright © 2017年 CH. All rights reserved.
//

#import "HomeCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation HomeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void) modelSetUp:(HomeListModel *) model {
    
    self.subTitle.text = [model valueForKey:@"name_en"];
    self.titleLabel.text = [model valueForKey:@"name"];
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:[[model valueForKey:@"photo" ] valueForKey:@"photo_url"]] placeholderImage:nil];
}

@end
