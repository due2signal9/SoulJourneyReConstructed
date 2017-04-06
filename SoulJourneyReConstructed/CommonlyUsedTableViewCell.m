//
//  CommonlyUsedTableViewCell.m
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/18.
//  Copyright © 2017年 CH. All rights reserved.
//

#import "CommonlyUsedTableViewCell.h"
//#import "HomeDetailViewController.h"
#import "OtherLinkModel.h"
#import "OtherViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation CommonlyUsedTableViewCell {
    
    UIView *tmp;
    NSMutableArray *constraints;
    NSMutableArray<OtherLinkModel *> *dataArray;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    constraints = [NSMutableArray arrayWithCapacity:6];
    
    [self.commonLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.commonLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:8.0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.commonLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:8.0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.commonLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-8.0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.commonLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:18.0]];
    // Initialization code
}

-(void)modelSetUp:(NSMutableArray<OtherLinkModel *> *)models {
    dataArray = models;
    for (int i = 0 ; i < models.count; i++) {
        
        
        UIButton *button = [[UIButton alloc] init];
        [button setTranslatesAutoresizingMaskIntoConstraints:NO];
        UIView *view = [[UIView alloc] init];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 3, 40, 40)];
        //NSLog(@"%@", models[i].photo_url);
        NSURL *url = [[NSURL alloc] initWithString:[models[i].photo_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [imageView sd_setImageWithURL:url placeholderImage:nil];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(48, 21, 241, 4)];
        [lineView setBackgroundColor:[UIColor darkGrayColor]];
        UILabel *kindLabel = [[UILabel alloc] initWithFrame:CGRectMake(297, 13, 54, 21)];
        [kindLabel setTextAlignment:NSTextAlignmentRight];
        [kindLabel setText:models[i].title];
        
        [view addSubview:imageView];
        [view addSubview:lineView];
        [view addSubview:kindLabel];
        [view addSubview:button];
        [self.contentView addSubview:view];
        
        [view addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
        [view addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
        [view addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
        [view addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
        
        button.tag = i;
        
        [button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        if (i == 0) {
            
            NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.commonLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:8.0];
            NSLayoutConstraint *constraint2 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:8.0];
            NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-8.0];
            NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:47.0];
            [constraints addObject:constraint1];
            [constraints addObject:constraint2];
            [constraints addObject:constraint3];
            [constraints addObject:constraint4];
        } else {
            
            NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:tmp attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.0];
            NSLayoutConstraint *constraint2 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:8.0];
            NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-8.0];
            NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:47.0];
            [constraints addObject:constraint1];
            [constraints addObject:constraint2];
            [constraints addObject:constraint3];
            [constraints addObject:constraint4];
            if (i == models.count - 1) {
                
                NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-8.0];
//                NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:8.0];
                [constraints addObject:constraint];
            }
        }
        
        view.userInteractionEnabled = YES;
        
        tmp = view;
        
        //[button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == models.count - 1) {
            
            [self.contentView addConstraints:constraints];
            //[self layoutIfNeeded];
        }
    }
}

-(void)btnClicked: (UIButton *)button {
    
    [_delegate showOther:button.tag];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
