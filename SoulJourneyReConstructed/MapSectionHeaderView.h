//
//  MapSectionHeaderView.h
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/31.
//  Copyright © 2017年 CH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MapSectionHeaderViewDelegate <NSObject>

- (void)showDetails:(NSInteger)index;

@end

@interface MapSectionHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *bigLabel;
@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (weak, nonatomic) IBOutlet UIButton *detailButton;
@property id<MapSectionHeaderViewDelegate> delegate;

@end
