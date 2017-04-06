//
//  TrackDetailTableViewCell.m
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/4/5.
//  Copyright © 2017年 CH. All rights reserved.
//

#import "TrackDetailTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation TrackDetailTableViewCell {
    
    TrackModel *myModel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    layout.minimumLineSpacing = 3;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // Initialization code
}

-(void)modelSetUp:(TrackModel *)model {
    
    myModel = model;
    self.topImageView.tag = 0;
    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:[model.contents[0] valueForKey:@"photo_url"]] placeholderImage:nil];
    self.titleLabel.text = model.topic;
    self.contentLabel.text = model.content;
    [self.topImageView setUserInteractionEnabled:YES];
    [self.topImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPic:)]];
    NSString *btnName = [NSString stringWithFormat:@"%@:%@足迹%ld篇", model.user.name, [model.districts[0] valueForKey:@"name"], (long)model.parent_district_count];
    [self.moreButton setTitle:btnName forState:UIControlStateNormal];
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    UIImageView *imageView = [[UIImageView alloc] init];
    double width = [[[myModel.contents objectAtIndex:indexPath.row+1] valueForKey:@"width"] doubleValue];
    double height = [[[myModel.contents objectAtIndex:indexPath.row+1] valueForKey:@"height"] doubleValue];
    double ratio = width/height;
    imageView.frame = CGRectMake(0, 0, 75 * ratio, 75);
    imageView.tag = indexPath.row+1;
    //imageView.userInteractionEnabled = YES;
    if (myModel != nil) {
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:[myModel.contents[indexPath.row+1] valueForKey:@"photo_url"]] placeholderImage:nil];
    }
    
    //cell.backgroundColor = [UIColor redColor];
    cell.backgroundView = imageView;
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (myModel == nil) {
        
        return 0;
    } else {
        
        return myModel.contents.count - 1;
    }
}

- (void)showPic: (UIGestureRecognizer *)gesture {
    
    [self.delegate showPicController:gesture.view.tag];
}

- (void)show:(NSInteger)index {
    
    [self.delegate showPicController:index];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    double width = [[[myModel.contents objectAtIndex:indexPath.row+1] valueForKey:@"width"] doubleValue];
    double height = [[[myModel.contents objectAtIndex:indexPath.row+1] valueForKey:@"height"] doubleValue];
    double ratio = width/height;

    return CGSizeMake(75 * ratio, 75);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self show:indexPath.row+1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
