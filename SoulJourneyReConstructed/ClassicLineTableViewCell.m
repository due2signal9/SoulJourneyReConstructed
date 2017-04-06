//
//  ClassicLineTableViewCell.m
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/18.
//  Copyright © 2017年 CH. All rights reserved.
//

#import "ClassicLineTableViewCell.h"
//#import <AMapFoundationKit/AMapFoundationKit.h>
//#import <AMapLocationKit/AMapLocationKit.h>
#import <MAMapKit/MAMapKit.h>
#import "LineModel.h"

@interface ClassicLineTableViewCell() <MAMapViewDelegate>

@end

@implementation ClassicLineTableViewCell {
    
    MAMapView *mainMapView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    mainMapView = [[MAMapView alloc] initWithFrame:self.coverImageView.bounds];
    mainMapView.delegate = self;
    mainMapView.showsScale = NO;
    
    mainMapView.scrollEnabled = NO;
    
    [self.coverImageView addSubview:mainMapView];
    // Initialization code
}

- (void)modelSetUp:(LineModel *)model {
    
    [self addPoints:[model.days[0] valueForKey:@"points"]];
}

- (void)addPoints: (NSMutableArray<PointModel *> *)points {
    
    //dian
    NSInteger size = points.count;
    CLLocationCoordinate2D newPoints[size];
    //zhushi
    NSMutableArray *annotations = [NSMutableArray arrayWithCapacity:5];
    
    for (int i = 0; i < size; i++) {
        
        PointModel *p = [points objectAtIndex:i];
        
        MAPointAnnotation *point = [[MAPointAnnotation alloc] init];
        point.coordinate = CLLocationCoordinate2DMake([[[p valueForKey:@"poi"] valueForKey:@"lat"] doubleValue], [[[p valueForKey:@"poi"] valueForKey:@"lng"] doubleValue]);
        point.title = [[p valueForKey:@"poi"] valueForKey:@"name"];
        [mainMapView addAnnotation:point];
        CLLocationCoordinate2D v = CLLocationCoordinate2DMake([[[p valueForKey:@"poi"] valueForKey:@"lat"] doubleValue],  [[[p valueForKey:@"poi"] valueForKey:@"lng"] doubleValue]);
//        NSValue *value = [NSValue valueWithBytes:&v objCType:@encode(CLLocationCoordinate2D)];
        newPoints[i] = v;
        [annotations addObject:point];
    }
    
    [mainMapView showAnnotations:annotations animated:YES];
    MAPolyline *line = [MAPolyline polylineWithCoordinates:newPoints count:size];
    [mainMapView addOverlay:line];
    
}

//delegate and datasource 设置气泡样式
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    
    if ([annotation isKindOfClass: [MAPointAnnotation class]]) {
        
        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mainMapView dequeueReusableAnnotationViewWithIdentifier:@"annotationView"];
        if (annotationView == nil) {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotationView"];
        }
        annotationView.image = [UIImage imageNamed:@"dingwei"];
        annotationView.canShowCallout = YES;
        annotationView.animatesDrop = YES;
        
        return annotationView;
    }
    return nil;
}

//设置折线类型

-(MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay {
    
    if ([overlay isKindOfClass:[MAPolyline class]]) {
        
        MAPolylineRenderer *polyLine = [[MAPolylineRenderer alloc] initWithOverlay:overlay];
        polyLine.lineWidth = 3;
        polyLine.strokeColor = [UIColor redColor];
        
        [polyLine setLineJoin:kCGLineJoinRound];
        [polyLine setLineCap:kCGLineCapRound];
        
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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end













