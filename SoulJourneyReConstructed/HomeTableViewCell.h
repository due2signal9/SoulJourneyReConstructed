//
//  HomeTableViewCell.h
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/16.
//  Copyright © 2017年 CH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@protocol PushOtherControllerDelegate
    
- (void)pushController:(int) section :(int) index;
- (void)pushAllLandController: (NSString *)region;

@end


@interface HomeTableViewCell : UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *checkAllBtn;

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property id<PushOtherControllerDelegate> delegate;
@property HomeModel *model;

@property int section;
- (void)modelSetUp: (HomeModel *)model;

@end
