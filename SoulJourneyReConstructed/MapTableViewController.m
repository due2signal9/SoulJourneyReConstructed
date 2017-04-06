//
//  MapTableViewController.m
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/30.
//  Copyright © 2017年 CH. All rights reserved.
//

#import "MapTableViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <KVNProgress.h>
#import <UMSocialCore/UMSocialCore.h>
#import <FMDatabase.h>
#import "DataBase.h"
#import "MapViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface MapTableViewController () <UITableViewDelegate, UITableViewDataSource, MAMapViewDelegate, MapSectionHeaderViewDelegate>

@end

@implementation MapTableViewController {
    
    MAMapView *myMapView;
    //double sectionHeaderHeight;
  //  MapSectionHeaderView *header_view;
    //NSMutableArray<NSNumber *> *isExpand;
    NSInteger isExpand[100];
    double sectionHeight[100];
}

-(void)showFromTracks:(NSString *)id {
    
    [self getNetData:id];
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    for (int i = 0; i < 99; i++) {
        
        isExpand[i] = 0;
        sectionHeight[i] = 30;
    }
    myMapView = [[MAMapView alloc] init];
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = view;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.tableView.hidden = YES;
    
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self.tableView reloadData];
    self.tableView.hidden = NO;
    [self addPoints:[self.model.days[0] valueForKey:@"points"]];
}

- (void)createUI {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(shareClicked)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    myMapView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200);
    myMapView.delegate = self;
    myMapView.showsScale = false;
    
    self.tableView.tableHeaderView = myMapView;
    
    [self.joinTrackBtn setTitle:@"加入行程单" forState:UIControlStateNormal];
    [self.joinTrackBtn setBackgroundColor:[UIColor colorWithRed:21/255 green:176/255 blue:138/255 alpha:0.8]];
    [self.joinTrackBtn addTarget:self action:@selector(joinTrackBtnClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)joinTrackBtnClicked {
    
    DataBase *database = [DataBase sharedDataBase];
    if (database) {
        
        if(![database isExist:self.model.title]) {
            
            [KVNProgress showWithStatus:@"正在加入"];
            [database addTrack:self.model :self.photoUrl];
            [KVNProgress showSuccessWithStatus:@"加入行程成功"];
        } else {
            
            [KVNProgress showErrorWithStatus:@"已在行程单中"];
        }
    }
}

- (void)shareClicked {
    
    if (self.model == nil) {
        return;
    } else {
        
        NSString *text = [self.model valueForKey:@"title"];
        UIImage *image = [[UIImage alloc] init];
        NSURL *url = [NSURL URLWithString:self.photoUrl];
        if (!url) {
            [KVNProgress showErrorWithStatus:@"分享失败"];
            return;
        } else {
            
            NSData *data = [[NSData alloc] initWithContentsOfURL:url];
            if (data) {
                image = [UIImage imageWithData:data];
            }
        }
        NSLog(@"偷偷模拟一次分享功能:%@", text);
        [KVNProgress showSuccessWithStatus:@"分享成功"];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if(self.model != nil) {
        NSLog(@"%lu", (unsigned long)_model.days.count);
        return self.model.days.count;
        //NSLog(@"%lu", (unsigned long)_model.days.count);
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    //return header_view;
    MapSectionHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"MapSectionHeaderView" owner:nil options:nil] lastObject];
    view.bigLabel.numberOfLines = 0;
    view.bigLabel.text = [self.model.days[section] valueForKey:@"description"];
    [view.bigLabel sizeToFit];
    //NSLog(@"%@", view.bigLabel.text);
    
    if (isExpand[section] == 1) {
        
        view.detailImageView.image = [UIImage imageNamed:@"arrow-up"];
    } else {
        
        view.detailImageView.image = [UIImage imageNamed:@"arrow-down"];
    }
    
    sectionHeight[section] = CGRectGetMaxY(view.bigLabel.frame) + 40;
    
    view.detailButton.tag = section;
    view.delegate = self;
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return sectionHeight[section];
    
    //return sectionHeaderHeight;
}

-(void)showDetails: (NSInteger)index{
    
    if (isExpand[index] == 0) {
        
        isExpand[index] = 1;
        
    } else {
        
        isExpand[index] = 0;
    }
    [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:index] withRowAnimation:UITableViewRowAnimationNone];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (isExpand[section] == 0) { // isExpand == NO
        
        return 0;
    } else {
        
        return ((NSArray *)[self.model.days[section] valueForKey:@"points"]).count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.model) {
        
        cell.imageView.image = [UIImage imageNamed:@"fangzi"];
        cell.textLabel.text = [[[[self.model.days[indexPath.section] valueForKey:@"points"]objectAtIndex:indexPath.row] valueForKey:@"inspiration_activity"] valueForKey:@"topic"];
        if ([[[[[self.model.days[indexPath.section] valueForKey:@"points"] objectAtIndex:indexPath.row] valueForKey:@"inspiration_activity"] valueForKey:@"visit_tip"] isEqualToString:@""]) {
            
            cell.detailTextLabel.text = [[[[[[self.model.days[indexPath.section] valueForKey:@"points"] objectAtIndex:indexPath.row] valueForKey:@"inspiration_activity"] valueForKey:@"inspiration_activity"] valueForKey:@"destination"] valueForKey:@"name"];
        } else {
            
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@·建议游玩%@", [[[[[self.model.days[indexPath.section] valueForKey:@"points"] objectAtIndex:indexPath.row] valueForKey:@"inspiration_activity"] valueForKey:@"destination"] valueForKey:@"name"],[[[[self.model.days[indexPath.section] valueForKey:@"points"] objectAtIndex:indexPath.row] valueForKey:@"inspiration_activity"] valueForKey:@"visit_tip"]];
        }
    }
    return cell;
}

- (void)getNetData:(NSString *)i_d {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSString *urlString = [NSString stringWithFormat:@"http://q.chanyouji.com/api/v3/destinations/%@.json", i_d];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error != nil) {
            
            NSLog(@"mapTV getNetData wrong!!!%@", error.description);
        } else {
            
            NSDictionary *dataDic = [((NSDictionary *)responseObject) objectForKey:@"data"];
            NSDictionary *sections = dataDic[@"sections"];
            for (NSDictionary *item in sections) {
                
                if ([(NSString *)item[@"type"] isEqualToString:@"Plan"]) {
                    
                    NSArray *models = item[@"models"];
                    self.model = [[LineModel alloc] initWithDictionary:models[0] error:nil];
                }
            }
        }
        [self.tableView reloadData];
        self.joinTrackBtn.hidden = YES;
    }];
    [dataTask resume];
}

- (void)addPoints:(NSMutableArray<PointModel *> *)pois {
    
    CLLocationCoordinate2D points[20];
    NSMutableArray<MAPointAnnotation *> *annonations = [NSMutableArray arrayWithCapacity:5];
    
    for (int i = 0; i < pois.count; i++) {
        
        MAPointAnnotation *point = [[MAPointAnnotation alloc] init];
        point.coordinate = CLLocationCoordinate2DMake([[[pois[i] valueForKey:@"poi"] valueForKey:@"lat"] doubleValue], [[[pois[i] valueForKey:@"poi"] valueForKey:@"lng"] doubleValue]);
        point.title = [[pois[i] valueForKey:@"poi"] valueForKey:@"name"];
        [myMapView addAnnotation:point];
        points[i] = CLLocationCoordinate2DMake([[[pois[i] valueForKey:@"poi"] valueForKey:@"lat"] doubleValue], [[[pois[i] valueForKey:@"poi"] valueForKey:@"lng"] doubleValue]);
        [annonations addObject:point];
    }
    [myMapView showAnnotations:annonations animated:YES];
    MAPolyline *line = [MAPolyline polylineWithCoordinates:points count:pois.count];
    [myMapView addOverlay:line];
}

-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        
        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"view"];
        if (annotation == nil) {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"view"];
        }
        annotationView.image = [UIImage imageNamed:@"dingwei"];
        annotationView.canShowCallout = true;
        annotationView.animatesDrop = true;
        
        return annotationView;
    }
    return nil;
}

-(MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay {
    
    if ([overlay isKindOfClass:[MAPolylineRenderer class]]) {
        
        MAPolylineRenderer *polyLine = [[MAPolylineRenderer alloc] initWithOverlay:overlay];
        polyLine.lineWidth = 3.0;
        polyLine.strokeColor = [UIColor redColor];
        [polyLine setLineJoin:kCGLineJoinRound];
        [polyLine setLineCap:kCGLineCapSquare];
        
        return polyLine;
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    
    view.image = [UIImage imageNamed:@"dingwei_select"];
}

- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view {
    
    view.image = [UIImage imageNamed:@"dingwei"];
}

- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate {
    
    MapViewController *vc = [[MapViewController alloc] init];
    [vc modelSetUp:self.model];
    [self.navigationController pushViewController:vc animated:YES];
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
