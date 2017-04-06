//
//  TrackDetailTableViewCell.h
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/4/5.
//  Copyright © 2017年 CH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrackModel.h"

@protocol TrackDetailTableViewCellDelegate <NSObject>

- (void)showPicController:(NSInteger)index;

@end

@interface TrackDetailTableViewCell : UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property id<TrackDetailTableViewCellDelegate> delegate;

- (void)modelSetUp:(TrackModel *)model;

@end
