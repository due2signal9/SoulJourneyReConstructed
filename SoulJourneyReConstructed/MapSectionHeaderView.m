//
//  MapSectionHeaderView.m
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/31.
//  Copyright © 2017年 CH. All rights reserved.
//

#import "MapSectionHeaderView.h"

@implementation MapSectionHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)buttonClicked:(id)sender {
    
    [self.delegate showDetails:((UIButton *)sender).tag];
}

@end
