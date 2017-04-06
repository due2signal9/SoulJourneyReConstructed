//
//  HomeDetailViewController.h
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/18.
//  Copyright © 2017年 CH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeListModel.h"
#import "CommonlyUsedTableViewCell.h"
#import <MWPhotoBrowser/MWPhotoBrowser.h>
#import "RelatedTableViewCell.h"

@class CommonlyUsedTableViewCell;

@interface HomeDetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, CommonlyUsedTableViewCellDelegate, MWPhotoBrowserDelegate, RelatedTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UIView *header;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@property (weak, nonatomic) IBOutlet UITableView *detailTableView;
@property NSString *name;
@property NSInteger id_en;
@property NSString *photoUrl;

//- (void)modelSetUp: (HomeListModel *)model;

@end
