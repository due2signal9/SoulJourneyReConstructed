//
//  HomeViewController.m
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/14.
//  Copyright © 2017年 CH. All rights reserved.
//

#import "HomeViewController.h"
#import "SDCycleScrollView.h"
#import "AppDelegate.h"
#import "BannerModel.h"
#import "HomeListModel.h"
#import "HomeModel.h"
#import "HomeTableViewCell.h"
#import <SDWebImage//UIImageView+WebCache.h>
#import "LandsCollectionViewCell.h"
#import "AllLandViewController.h"
#import <MJRefresh.h>
#import <MJRefresh/NSBundle+MJRefresh.h>
#import <KVNProgress.h>

#import <AFNetworking.h>

@interface HomeViewController () <SDCycleScrollViewDelegate, PushOtherControllerDelegate>
    
    @property (weak, nonatomic) IBOutlet SDCycleScrollView *banner;
@property (weak, nonatomic) IBOutlet UITableView *homeTableView;


@end

@implementation HomeViewController {
    
    //NSString *homeTableViewCellReuseID;
    AMapLocationManager *locationManager;
    NSMutableArray *bannerDataArray;
    NSMutableArray *homeDataArray;
}

- (void)loadData {
    
    [bannerDataArray removeAllObjects];
    [homeDataArray removeAllObjects];
    [self getDataOfBanner];
    [self getHomePageData];
    [self location];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    bannerDataArray = [NSMutableArray arrayWithCapacity:5];
    homeDataArray = [NSMutableArray arrayWithCapacity:5];
    locationManager = [[AMapLocationManager alloc] init];
    
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"下拉刷新数据" forState:MJRefreshStateIdle];
    [header setTitle:@"松开开始刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"刷新中..." forState:MJRefreshStateRefreshing];
    self.homeTableView.mj_header = header;
    
    [self createUI];
    [self navigationSetting];
    //将轮播图添加到tableheadview 初始化tableview设置
    self.homeTableView.tableHeaderView = self.banner;
    self.homeTableView.delegate = self;
    self.homeTableView.dataSource = self;
    //self.homeTableView.rowHeight = 400;
    self.homeTableView.showsVerticalScrollIndicator = NO;
    
    //collectionView sets
    [self.homeTableView.mj_header beginRefreshing];
    //BlurEffects
    
}

//界面代码
- (void)createUI {
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.banner.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.banner.autoScrollTimeInterval = 4.0;
    self.banner.delegate = self;
    //   self.banner.titlesGroup = titles;
    self.banner.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    //self.banner.placeholderImage = [UIImage imageNamed:@"placeholder"];
    
}


- (void)navigationSetting {
    
    //UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"search.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(searchAction)];
    self.navigationController.navigationBar.backgroundColor = [UIColor lightGrayColor];
    //self.navigationItem.rightBarButtonItem = rightBtn;
}

- (void)location {
    
    locationManager.delegate = self;
    
    //百米误差
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    
    [locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error != nil) {
            
            NSLog(@"定位失败：%@", error);
            [self.homeTableView.mj_header endRefreshing];
            [KVNProgress showErrorWithStatus:@"定位失败"];
        }
        
        if (location != nil) {
            
            NSLog(@"%f,%f",location.coordinate.latitude,location.coordinate.longitude);
            NSString *lat = [NSString stringWithFormat:@"%f", 39.004];
            NSString *lng = [NSString stringWithFormat:@"%f", 114.003];
            [self getDataNearBy:lat :lng];  // 39.004, 114.003
            [locationManager stopUpdatingLocation];
        }
        
        if (regeocode != nil) {
            
            NSLog(@"定位信息：%@", regeocode);
            [self.homeTableView.mj_header endRefreshing];
        }
    }];
    
}
//网络数据的获取
- (void)getDataNearBy: (NSString *)lat : (NSString *)lng {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString *urlString = @"http://q.chanyouji.com/api/v2/destinations/nearby.json";
    NSDictionary *parameters = @{@"lat": lat, @"lng": lng};
    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:urlString parameters:parameters error:nil];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error != nil) {
            
            NSLog(@"ERROR!!! %@", error);
            [self.homeTableView.mj_header endRefreshing];
        } else {
            
            NSArray *dataArray = [((NSDictionary *)responseObject) objectForKey:@"data"];
            HomeModel *homeModel = [[HomeModel alloc] init];
            NSMutableArray *homeListModels = [NSMutableArray arrayWithCapacity:5];
            for (NSDictionary *dic in dataArray) {
                
                HomeListModel *newModel = [[HomeListModel alloc] initWithDictionary:dic error:nil];

                [homeListModels addObject:newModel];
            }
            homeModel.button_text = [NSString stringWithFormat:@"附近%lu处景点", (unsigned long)homeListModels.count];
            
            homeModel.destinations = homeListModels;
            homeModel.name = @"附近景点";
            homeModel.region = @"near";
            if (homeModel != nil) {
            [homeDataArray insertObject:homeModel atIndex:0];
            }
            NSLog(@"count is ===================== %lu", (unsigned long)homeDataArray.count);
            NSLog(@"%@", responseObject);
            
            [self.homeTableView reloadData];
            [self.homeTableView.mj_header endRefreshing];
        }
    }];
    [dataTask resume];
}

//
- (void)getDataOfBanner {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://q.chanyouji.com/api/v1/adverts.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            
            NSMutableArray *url_banners = [NSMutableArray arrayWithCapacity:5];
            NSArray *bannerArray = [((NSDictionary *)responseObject) objectForKey:@"data"];
            for (NSDictionary *dic in bannerArray) {
                
                BannerModel *bannerModel = [[BannerModel alloc] initWithDictionary:dic error:nil];
                

                //[url_banners addObject:[bannerModel.photo valueForKey:@"photo_url"]];
                [url_banners addObject:bannerModel.photo.photo_url];
                
                
                [bannerDataArray addObject:bannerModel];
            }
            
            self.banner.imageURLStringsGroup = url_banners;
        }
    }];
    [dataTask resume];

}

- (void)getHomePageData {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *url = [NSURL URLWithString:@"http://q.chanyouji.com/api/v2/destinations.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error != nil) {
            
            NSLog(@"HomeData requesting ERROR!");
        } else {
            
            NSArray *dataArray = [((NSDictionary *)responseObject) objectForKey:@"data"];
            for (NSDictionary *dic in dataArray) {
                
                HomeModel *model = [[HomeModel alloc] initWithDictionary:dic error:nil];
                [homeDataArray addObject:model];
                
            }
            [self.homeTableView reloadData];
        }
    }];
    [dataTask resume];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"homeTVCReuseID";
    
    static BOOL nibRegistered = NO;
    
    if (!nibRegistered) {
        
        UINib *nib = [UINib nibWithNibName:@"HomeTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:cellID];
        nibRegistered = YES;
    }
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    if (homeDataArray.count > 0) {
        cell.mainImageView.tag = indexPath.section;
        HomeModel *destination = (HomeModel *)homeDataArray[indexPath.section];
        
        [cell modelSetUp:destination];
        
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 415;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return homeDataArray.count;
}


-(void)pushAllLandController:(NSString *)region {
    
    AllLandViewController *allVC = [[AllLandViewController alloc] init];
    if ([region  isEqual: @"near"]) {
        
        [allVC modelSetUp:[homeDataArray[0] valueForKey:@"destinations"]];
    } else {
        
        [allVC getData:region];
    }
    allVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:allVC animated:YES];
}
//搜索
- (void)searchAction {
    
//===================================

}


- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    
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
