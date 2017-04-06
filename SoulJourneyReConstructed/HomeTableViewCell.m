//
//  HomeTableViewCell.m
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/16.
//  Copyright © 2017年 CH. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "HomeModel.h"
#import "HomeListModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "HomeCollectionViewCell.h"

@implementation HomeTableViewCell

- (void)modelSetUp: (HomeModel *)model {
    
    self.model = model;
    
    self.nameLabel.text = model.name;
    [self.checkAllBtn setTitle:model.button_text forState:UIControlStateNormal];
    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:[[((HomeListModel *)(model.destinations[0])) valueForKey:@"photo" ]valueForKey:@"photo_url"]]  placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    [self.collectionView reloadData];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"HomeCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"HomeCVCID"];
    // Initialization code
}
- (IBAction)checkAllAction:(id)sender {
    
    if (self.delegate) {
        
        [self.delegate pushAllLandController:[self.model valueForKey:@"region"]];
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCVCID" forIndexPath:indexPath];
    if (self.model != nil) {
        
        [cell modelSetUp:self.model.destinations[indexPath.row]];
    }
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (self.model != nil) {
        
        return 3;
    }
    return 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
