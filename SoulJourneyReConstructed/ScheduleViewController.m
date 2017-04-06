//
//  ScheduleViewController.m
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/14.
//  Copyright © 2017年 CH. All rights reserved.
//

#import "ScheduleViewController.h"
#import <KVNProgress.h>
#import "DataBase.h"
#import "ScheduleTableViewCell.h"
#import "MapTableViewController.h"

@interface ScheduleViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ScheduleViewController {
    
    NSMutableArray<TrackLineModel *> *models;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view from its nib.
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ScheduleTableViewCell" bundle:nil] forCellReuseIdentifier:@"ScheduleTVCID"];

}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        models = [[DataBase sharedDataBase] getAllTracks];
        if (models) {
            
            [self.tableView reloadData];
        } else {
            
            [KVNProgress showErrorWithStatus:@"打开数据库失败"];
        }
    });
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 130;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ScheduleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScheduleTVCID" forIndexPath:indexPath];
    
    [cell modelSetUp:models[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return models.count;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return true;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [[DataBase sharedDataBase] deleteTrack:models[indexPath.row].title];
    [models removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MapTableViewController *mapVC = [[MapTableViewController alloc] init];
    [mapVC showFromTracks:models[indexPath.row].id];
    mapVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:mapVC animated:YES];
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
