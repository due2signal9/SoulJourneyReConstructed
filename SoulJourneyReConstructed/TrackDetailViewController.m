//
//  TrackDetailViewController.m
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/4/4.
//  Copyright © 2017年 CH. All rights reserved.
//

#import "TrackDetailViewController.h"
#import "TrackDetailTableViewCell.h"

@interface TrackDetailViewController () <UITableViewDelegate, UITableViewDataSource, TrackDetailTableViewCellDelegate>

@end

@implementation TrackDetailViewController {
    
    NSMutableArray *imageUrls;
    TrackModel *myModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TrackDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"TrackDetailTVCID"];
    
    self.navigationItem.title = [myModel.districts[0] valueForKey:@"name"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(shareToWeChat)];
    // Do any additional setup after loading the view from its nib.
}

-(void)modelSetUp:(TrackModel *)model {
    
    myModel = model;
    imageUrls = [NSMutableArray arrayWithCapacity:5];
}

- (void)imageUrlsSetUp {
    
    for (PhotoModel *photoModel in myModel.contents) {
        
        [imageUrls addObject:[photoModel valueForKey:@"photo_url"]];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TrackDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TrackDetailTVCID" forIndexPath:indexPath];
    [cell modelSetUp:myModel];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    //
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 650;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    return UITableViewAutomaticDimension;
}

- (void)shareToWeChat {
    
    
}

- (void)showPicController:(NSInteger)index {
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    [browser setCurrentPhotoIndex:index];
    [self.navigationController pushViewController:browser animated:YES];
}

-(NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    
    return myModel.contents.count;
}

- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    
    if (index < myModel.contents.count) {
        
        return [[MWPhoto alloc] initWithURL:[NSURL URLWithString:[[myModel.contents objectAtIndex:index] valueForKey:@"photo_url"]]];
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
