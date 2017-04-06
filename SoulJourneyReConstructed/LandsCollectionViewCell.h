//
//  LandsCollectionViewCell.h
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/18.
//  Copyright © 2017年 CH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeListModel.h"

@interface LandsCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNameLabel;
- (void)modelSetUp : (HomeListModel *)model;


@end
