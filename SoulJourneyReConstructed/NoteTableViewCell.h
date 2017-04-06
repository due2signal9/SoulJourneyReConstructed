//
//  NoteTableViewCell.h
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/25.
//  Copyright © 2017年 CH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
