//
//  AllLandViewController.m
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/18.
//  Copyright © 2017年 CH. All rights reserved.
//

#import "AllLandViewController.h"
#import <AFNetworking.h>
#import "LandsCollectionViewCell.h"
#import "HomeDetailViewController.h"

@interface AllLandViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation AllLandViewController {
    
    NSMutableArray<HomeListModel *> *areaDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"LandsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"LandsCVCID"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    // Do any additional setup after loading the view from its nib.
}

- (void)modelSetUp: (NSMutableArray *)model {
    
    areaDataArray = model;
    NSLog(@"%@",areaDataArray);
    [self.collectionView reloadData];
}

- (void)getData : (NSString *)region {
    
    if ([region isEqualToString:@"near"]) {
        return;
    }
    
    areaDataArray = [NSMutableArray arrayWithCapacity:5];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString *urlString = @"http://q.chanyouji.com/api/v2/destinations/list.json";
    NSDictionary *params = @{ @"area" : region};
    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:urlString parameters:params error:nil];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error != nil) {
            
            NSLog(@"area_data requesting ERROR!");
        } else {
            
            NSArray *dataArray = [((NSDictionary *)responseObject) objectForKey:@"data"];
            for (NSDictionary *dic in dataArray) {
                
                HomeListModel *model = [[HomeListModel alloc] initWithDictionary:dic error:nil];
                [areaDataArray addObject:model];
                
            }
            [self.collectionView reloadData];
        }
    }];
    [dataTask resume];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (areaDataArray) {
        
        return areaDataArray.count;
    }
    return 0;
        
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LandsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LandsCVCID" forIndexPath:indexPath];
    if (areaDataArray) {
        
        [cell modelSetUp:areaDataArray[indexPath.row]];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeDetailViewController *vc = [[HomeDetailViewController alloc] init];
    if (areaDataArray) {
        
        vc.name = [areaDataArray[indexPath.row] valueForKey:@"name"];
        vc.id_en = areaDataArray[indexPath.row].id;
        vc.photoUrl = [[areaDataArray[indexPath.row] valueForKey:@"photo"] valueForKey:@"photo_url"];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
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
