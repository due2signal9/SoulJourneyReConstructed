//
//  TrackViewController.m
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/14.
//  Copyright © 2017年 CH. All rights reserved.
//

#import "TrackViewController.h"
#import <MJRefresh.h>
#import "TrackModel.h"
#import <AFNetworking/AFNetworking.h>
#import "TrackTableViewCell.h"
#import "TrackDetailViewController.h"

@interface TrackViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation TrackViewController {
    
    NSMutableArray<TrackModel *> *myDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    myDataArray = [NSMutableArray arrayWithCapacity:10];
    
    [self createUI];
    [self Refresher];
    [self getData];
    // Do any additional setup after loading the view from its nib.
}

- (void)createUI {
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIFont boldSystemFontOfSize:17] forKey:NSFontAttributeName];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TrackTableViewCell" bundle:nil] forCellReuseIdentifier:@"TrackTVCID"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 250;
}

- (void)Refresher {
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [myDataArray removeAllObjects];
        [self getData];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self getData];
    }];
}

- (void)getData {
   // @"http://q.chanyouji.com/api/v1/timelines.json"
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString *urlStr = @"http://q.chanyouji.com/api/v1/timelines.json";
    NSDictionary *params = @{ @"page":@((myDataArray.count/20)+1), @"per":@20};
    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:urlStr parameters:params error:nil];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error != nil) {
            
            NSLog(@"error !! %@", error);
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        } else {
            
            NSArray *dataArray = [((NSDictionary *)responseObject) objectForKey:@"data"];
            for (NSDictionary *item in dataArray) {
                
                NSDictionary *activity = item[@"activity"];
                if (activity != nil) {
                    
                    TrackModel *model = [[TrackModel alloc] initWithDictionary:activity error:nil];
                    [myDataArray addObject:model];
                }
            }
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
        }
    }];
    [dataTask resume];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TrackTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TrackTVCID" forIndexPath:indexPath];
    if (myDataArray.count > 0) {
        
        [cell modelSetUp:myDataArray[indexPath.row]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return myDataArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TrackDetailViewController *detailVC = [[TrackDetailViewController alloc] init];
    detailVC.hidesBottomBarWhenPushed = YES;
    [detailVC modelSetUp:myDataArray[indexPath.row]];
    [self.navigationController pushViewController:detailVC animated:YES];
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
