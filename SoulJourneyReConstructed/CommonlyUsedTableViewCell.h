//
//  CommonlyUsedTableViewCell.h
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/18.
//  Copyright © 2017年 CH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OtherLinkModel.h"

@protocol CommonlyUsedTableViewCellDelegate <NSObject>

- (void)showOther:(NSInteger)index;

@end

@interface CommonlyUsedTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *commonLabel;
@property(weak) id<CommonlyUsedTableViewCellDelegate> delegate;

- (void)modelSetUp:(NSMutableArray<OtherLinkModel *> *)models;

@end
