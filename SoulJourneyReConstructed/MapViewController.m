//
//  MapViewController.m
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/30.
//  Copyright © 2017年 CH. All rights reserved.
//

#import "MapViewController.h"
#import "MapCollectionViewCell.h"

@interface MapViewController () <MAMapViewDelegate, UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation MapViewController {
    
    NSMutableArray *allAnnotations;
    NSMutableArray *lineArray;
    LineModel *myModel;
    UICollectionView *myCollection;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    allAnnotations = [NSMutableArray arrayWithCapacity:5];
    lineArray = [NSMutableArray arrayWithCapacity:5];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    myCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 548, 375, 70) collectionViewLayout:layout];
    
    self.mapView.delegate = self;
    //self.automaticallyAdjustsScrollViewInsets = NO;
    [self addPoints:myModel.days];
    
    myCollection.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [myCollection registerNib:[UINib nibWithNibName:@"MapCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MapCVCID"];
    
    myCollection.delegate = self;
    myCollection.dataSource = self;
    [self.view addSubview:myCollection];
    // Do any additional setup after loading the view from its nib.
}

-(void)modelSetUp:(LineModel *)model {
    
    myModel = model;
}

- (void)addPoints: (NSArray<DayModel *> *)days {
    
    CLLocationCoordinate2D points[100];
    NSMutableArray *annotations = [NSMutableArray arrayWithCapacity:5];
    
    NSInteger count = 0;
    
    for (int i = 0; i < days.count; i++) {
        
        NSMutableArray *tmpAnnotations = [NSMutableArray arrayWithCapacity:5];
        for (int j = 0; j < ((NSArray *)[days[i] valueForKey:@"points"]).count; j++) {
            
            MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
            annotation.title = [[[[days[i] valueForKey:@"points"] objectAtIndex:j] valueForKey:@"poi"] valueForKey:@"name"];
            
            //[[[[days[i] valueForKey:@"points"] objectAtIndex:j] valueForKey:@"poi"] valueForKey:@"lat"]
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([[[[[days[i] valueForKey:@"points"] objectAtIndex:j] valueForKey:@"poi"] valueForKey:@"lat"] doubleValue], [[[[[days[i] valueForKey:@"points"] objectAtIndex:j] valueForKey:@"poi"] valueForKey:@"lng"] doubleValue]);
            annotation.coordinate = coordinate;
            [annotations addObject:annotation];
            [tmpAnnotations addObject:annotation];
            points[count] = coordinate;
            count++;
        }
        
        [allAnnotations addObject:tmpAnnotations];
        MAPolyline *line = [MAPolyline polylineWithCoordinates:points count:count];
        [self.mapView addOverlay:line];
        [lineArray addObject:line];
        
    }
    [self.mapView addAnnotations:annotations];
    [self.mapView showAnnotations:annotations animated:NO];
}

-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        
        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"view"];
        if (!annotationView) {
            
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"view"];
        }
        annotationView.image = [UIImage imageNamed:@"dingwei"];
        annotationView.canShowCallout = YES;
        annotationView.animatesDrop = YES;
        
        return annotationView;
    }
    return nil;
}

-(MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay {
    
    if ([overlay isKindOfClass:[MAPolyline class]]) {
        
        MAPolylineRenderer *polyline = [[MAPolylineRenderer alloc] initWithOverlay:overlay];
        polyline.lineWidth = 3;
        polyline.strokeColor = [UIColor redColor];
        [polyline setLineJoin:kCGLineJoinRound];
        [polyline setLineCap:kCGLineCapRound];
        
        return polyline;
    }
    return nil;
}

-(void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    
    view.image = [UIImage imageNamed:@"dingwei_select"];
}

-(void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view {
    
    view.image = [UIImage imageNamed:@"dingwei"];
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"willDisplay!!!!!"); //yes
}

-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"end display!!!!!"); //no???!!!
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MapCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MapCVCID" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.text = [NSString stringWithFormat:@"第%ld天", indexPath.section+1];
        cell.textLabel.textColor = [UIColor greenColor];
    } else {
        
        cell.textLabel.font = [UIFont systemFontOfSize:10];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.text = [NSString stringWithFormat:@"%ld\n%@", indexPath.row, [[[[myModel.days[indexPath.section] valueForKey:@"points"] objectAtIndex:indexPath.row-1] valueForKey:@"poi"] valueForKey:@"name"]];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return myModel.days.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return ((NSArray *)[myModel.days[section] valueForKey:@"points"]).count+1;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(50, 50);
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        [self.mapView removeOverlays:lineArray];
        for (int i = 0; i < allAnnotations.count; i++) {
            
            [self.mapView removeAnnotations:allAnnotations[i]];
            
            if (i == indexPath.section) {
                
                [self.mapView addOverlay:lineArray[i]];
                [self.mapView addAnnotations:allAnnotations[i]];
                [self.mapView showAnnotations:allAnnotations[i] animated:NO];
            }
        }
    } else {
        
        [self.mapView selectAnnotation:allAnnotations[indexPath.section][indexPath.row-1] animated:NO];
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
