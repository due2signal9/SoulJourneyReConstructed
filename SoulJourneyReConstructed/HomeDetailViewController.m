//
//  HomeDetailViewController.m
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/18.
//  Copyright © 2017年 CH. All rights reserved.
//

#import "HomeDetailViewController.h"
#import "DetailHeaderView.h"
#import <AFNetworking/AFNetworking.h>
#import "LineModel.h"
#import "RelatedModel.h"
//#import "RelatedFrameModel.h"
#import "OtherLinkModel.h"
#import "ClassicLineTableViewCell.h"
#import <SDWebImage//UIImageView+WebCache.h>
#import "OtherViewController.h"
#import <KVNProgress.h>
#import <MWPhotoBrowser/MWPhotoBrowser.h>
#import "MapTableViewController.h"


@interface HomeDetailViewController ()

@end

@implementation HomeDetailViewController {
    
    //DetailHeaderView *header;
    
    HomeListModel *headerModel;
    LineModel *classicLineModel;
    RelatedModel *relatedModel;
//    RelatedFrameModel *relatedFrameModel;
    NSMutableArray<OtherLinkModel *> *otherLinkModel;
    
    NSMutableArray *totalType;
    NSMutableArray *photos;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    photos = [NSMutableArray arrayWithCapacity:9];
    //self.detailTableView.estimatedRowHeight = 200;
    //self.detailTableView.rowHeight = UITableViewAutomaticDimension;
    
    totalType = [NSMutableArray arrayWithCapacity:5];
    otherLinkModel = [NSMutableArray arrayWithCapacity:5];
    [self createUI];
    [self getDetailData];
    // Do any additional setup after loading the view from its nib.
}

- (void)createUI {
    
    self.view.backgroundColor = [UIColor clearColor];
    self.navigationItem.title = self.name;
    //self.navigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName ]
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    //header = [[[NSBundle mainBundle] loadNibNamed:@"DetailHeaderView" owner:self options:nil] objectAtIndex:0];
    //header.hidden = YES;
    
    self.detailTableView.tableHeaderView = self.header;
    
    self.detailTableView.delegate = self;
    self.detailTableView.dataSource = self;
    
    self.detailTableView.showsVerticalScrollIndicator = NO;
    
    [self.detailTableView registerNib:[UINib nibWithNibName:@"ClassicLineTableViewCell" bundle:nil] forCellReuseIdentifier:@"ClassicLineTVCID"];
    [self.detailTableView registerNib:[UINib nibWithNibName:@"CommonlyUsedTableViewCell" bundle:nil] forCellReuseIdentifier:@"CommonlyUsedTVCID"];
    [self.detailTableView registerNib:[UINib nibWithNibName:@"RelatedTableViewCell" bundle:nil] forCellReuseIdentifier:@"RelatedTVCID"];
}



- (void)getDetailData {
    
    ///首页详情 需拼接id.json
    //let URL_HomePageDetail = "http://q.chanyouji.com/api/v3/destinations/"
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSLog(@"%ld", (long)self.id_en);
    NSString *urlString = [NSString stringWithFormat:@"http://q.chanyouji.com/api/v3/destinations/%@.json", [NSString stringWithFormat:@"%ld", (long)self.id_en]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error != nil) {
            
            NSLog(@"getDetailData error!!!");
        } else {
            
            NSDictionary *dataDic = [((NSDictionary *)responseObject) objectForKey:@"data"];
            //NSLog(@"datadic is %@", dataDic[@"destination"]);
            headerModel = [[HomeListModel alloc] initWithDictionary:[dataDic valueForKey:@"destination"] error:nil];
            //NSLog(@"headerModel is %@", headerModel);
            //header setup
            [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:[[headerModel valueForKey:@"photo"] valueForKey:@"photo_url"]] placeholderImage:nil];
            self.titleLabel.text = headerModel.name;
            self.subTitleLabel.text = headerModel.name_en;
            //
            
            NSDictionary *sections = dataDic[@"sections"];
            for (NSDictionary *item in sections) {
                
                if ([item[@"type"] isEqualToString:@"Plan"]) {
                    
                    NSArray *models = item[@"models"];
                    classicLineModel = [[LineModel alloc] initWithDictionary:models[0] error:nil];
                    [totalType addObject:@"Plan"];
                } else if ([item[@"type"] isEqualToString:@"UserActivity"]) {
                    
                    relatedModel = [[RelatedModel alloc] initWithDictionary:item error:nil];
                    //NSLog(@"%@", [[relatedModel valueForKey:@"models"][0] valueForKey:@"contents"]);
                    //relatedFrameModel = [[RelatedFrameModel  alloc] initWithDictionary:[relatedModel valueForKey:@"models"][0] error:nil];
                    
                    [totalType addObject:@"UserActivity"];
                }
            }
            NSArray *goods = dataDic[@"goods"];
            if (goods != nil) {
                
                for (NSDictionary *item in goods) {
                    
                    OtherLinkModel *model = [[OtherLinkModel alloc] initWithDictionary:item error:nil];
                    [otherLinkModel addObject:model];
                }
                [totalType insertObject:@"goods" atIndex:0];
            }
            [self.detailTableView reloadData];
            self.header.hidden = NO;
        }
        
    }];
    [dataTask resume];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([totalType[indexPath.section] isEqualToString:@"goods"]) {
        
        CommonlyUsedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommonlyUsedTVCID" forIndexPath:indexPath];
        [cell modelSetUp:otherLinkModel];
//        [cell.airBtn addTarget:self action:@selector(commonBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [cell.freeBtn addTarget:self action:@selector(commonBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [cell.termBtn addTarget:self action:@selector(commonBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if ([totalType[indexPath.section] isEqualToString:@"Plan"]) {
        
        ClassicLineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassicLineTVCID" forIndexPath:indexPath];
        if (classicLineModel != nil) {
            
            NSInteger count = classicLineModel.days_count;
            cell.daysLabel.text = [NSString stringWithFormat:@"%lu天行程", count];
            [cell modelSetUp:classicLineModel];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        
        RelatedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RelatedTVCID" forIndexPath:indexPath];
        if (relatedModel != nil) {
            
            cell.delegate = self;
            [cell dataModel:relatedModel];
        }
        NSArray<PhotoModel *> *contents = [relatedModel.models[0] valueForKey:@"contents"];
        NSInteger count = contents.count;
        for (int i = 0; i < count; i++) {
            
            [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:[contents[i] valueForKey:@"photo_url"]]]];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

- (void)showPicController:(NSInteger)index {
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    [browser setCurrentPhotoIndex:index];
    [self.navigationController pushViewController:browser animated:YES];
}

-(NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    
    return photos.count;
}

- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    
    if (index < photos.count) {
        
        return [photos objectAtIndex:index];
    }
    return nil;
}

-(void)showOther:(NSInteger)index {
    if (otherLinkModel[index].url == nil) {
        
        [KVNProgress showErrorWithStatus:@"😓没有找到链接"];
        return;
    }
    OtherViewController *otherVC = [[OtherViewController alloc] init];
    otherVC.title = otherLinkModel[index].title;
    otherVC.url = otherLinkModel[index].url;
    [self.navigationController pushViewController:otherVC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 200;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if ([totalType[indexPath.section] isEqualToString:@"goods"]) {
//     
//        return 200;
//    }
    return UITableViewAutomaticDimension;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([totalType[indexPath.section] isEqualToString:@"Plan"]) {
        
        MapTableViewController *mapVC = [[MapTableViewController alloc] init];
        mapVC.model = classicLineModel;
        mapVC.photoUrl = self.photoUrl;
        
        [self.navigationController pushViewController:mapVC animated:YES];
    }
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    if ([totalType[indexPath.section] isEqualToString:@"Plan"]) {
//        
//        return 362;
//    } else if ([totalType[indexPath.section] isEqualToString:@"goods"]) {
//        
//        return 183;
//    } else {
//        
//        return UITableViewAutomaticDimension;
//    }
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return totalType.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 36;
    }
    return 0;
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
