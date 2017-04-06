//
//  RelatedTableViewCell.h
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/20.
//  Copyright © 2017年 CH. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <MWPhotoBrowser/MWPhotoBrowser.h>
#import "RelatedModel.h"

//@class HomeDetailViewController;
@protocol RelatedTableViewCellDelegate <NSObject>

- (void)showPicController:(NSInteger)index;

@end

@interface RelatedTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UIView *imageContentView;

@property (weak, nonatomic) IBOutlet UILabel *contentTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *bottomBtn;
@property NSMutableArray *photoImageViews;
- (void)dataModel: (RelatedModel *)model;
- (void)dataOtherModel: (RelatedContentModel *)model;

@property(weak) id<RelatedTableViewCellDelegate> delegate;
//@property(weak) id<MWPhotoBrowserDelegate> delegate;
//@property(weak) HomeDetailViewController *m_delegate;
@end
