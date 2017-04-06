//
//  RelatedTableViewCell.m
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/20.
//  Copyright © 2017年 CH. All rights reserved.
//

#import "RelatedTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation RelatedTableViewCell {
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.photoImageViews = [NSMutableArray arrayWithCapacity:9];
    //self.contentTitleLabel.numberOfLines = 0;
    //self.contentLabel.numberOfLines = 0;
    //[self.bottomBtn setTitleColor:[UIColor colorWithRed:56/255.0 green:162/255.0 blue:249/255.0 alpha:1.0] forState:UIControlStateNormal];
    // Initialization code
}

-(void)dataModel:(RelatedModel *)model {
    
    self.headerLabel.text = @"相关足迹";
    
    [self xxxxx:model.models[0]];
    
    self.contentTitleLabel.text = [model.models[0] valueForKey:@"topic"];
    self.contentLabel.text = [model.models[0] valueForKey:@"summary"];
    [self.bottomBtn setTitle:[model valueForKey:@"button_text"] forState:UIControlStateNormal];
}

- (void)clicked: (UITapGestureRecognizer *)gesture {
    
    if (!self.delegate) return;
    [self.delegate showPicController:gesture.view.tag];
}

-(void)xxxxx:(RelatedContentModel *)model {
    
    NSInteger screenW = [UIScreen mainScreen].bounds.size.width;
    NSInteger length = (screenW - 32)/3;
    
    NSMutableArray *imageUrls = [NSMutableArray arrayWithCapacity:5];
    for (NSDictionary *item in [model valueForKey:@"contents"]) {
        
        [imageUrls addObject: [item valueForKey:@"photo_url"]];
    }
    
    //images settings
    if (imageUrls.count <= 3) {
        [self.photoImageViews removeAllObjects];
        for (int i = 0; i < imageUrls.count; i++) {
            
            UIImageView *imageView = [[UIImageView alloc] init];
            [self.photoImageViews addObject:imageView];
            imageView.userInteractionEnabled = YES;
            imageView.tag = i;
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked:)]];
            [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
            [self.imageContentView addSubview:imageView];
            [self.imageContentView addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.imageContentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:8.0]];
            [self.imageContentView addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.imageContentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-8.0]];
            [self.imageContentView addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:length]];
            [self.imageContentView addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:length]];
            if (i == 0) {
                
                [self.imageContentView addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.imageContentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
            } else if (i == 1) {
                [self.imageContentView addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.imageContentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
                
            } else if (i == 2) {
                
                [self.imageContentView addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.imageContentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
            }
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrls[i]] placeholderImage:nil];
        }
    } else {
        [self.photoImageViews removeAllObjects];
        NSMutableArray *rows = [NSMutableArray arrayWithCapacity:3];
        for (int row = 0; row < (imageUrls.count+2)/3; row++) {
            rows[row] = [NSMutableArray arrayWithCapacity:3];
            for (int col = 0; col < 3 && row*3 + col + 1 <= imageUrls.count; col++) {
                
                UIImageView *imageView = [[UIImageView alloc] init];
                //[self.photoImageViews removeAllObjects];
                [self.photoImageViews addObject:imageView];
                imageView.userInteractionEnabled = YES;
                imageView.tag = row*3 + col;
                [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked:)]];
                [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
                [self.imageContentView addSubview:imageView];
                if (row == 0) {
                    
                    [self.imageContentView addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.imageContentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:8.0]];
                } else {
                    
                    [self.imageContentView addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:rows[row-1][col] attribute:NSLayoutAttributeBottom multiplier:1.0 constant:8.0]];
                }
                if (col == 0) {
                    
                    [self.imageContentView addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.imageContentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
                } else if (col == 1) {
                    [self.imageContentView addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.imageContentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
                    
                } else if (col == 2) {
                    
                    [self.imageContentView addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.imageContentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
                }
                [self.imageContentView addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:length]];
                [self.imageContentView addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:length]];
                if (row == (imageUrls.count+2)/3 - 1) {
                    
                    [self.imageContentView addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.imageContentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-8.0]];
                }
                [rows[row] addObject:imageView];
                [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrls[row*3+col]] placeholderImage:nil];
            }
        }
    }
    //
}

-(void)dataOtherModel:(RelatedContentModel *)model {
    
    self.headerLabel.text = [model.user valueForKey:@"name"];
    [self xxxxx:model];
    self.contentTitleLabel.text = [model valueForKey:@"topic"];
    self.contentLabel.text = [model valueForKey:@"textContent"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
