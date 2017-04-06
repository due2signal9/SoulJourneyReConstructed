//
//  MapViewController.h
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/30.
//  Copyright © 2017年 CH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineModel.h"
#import <MAMapKit/MAMapKit.h>

@interface MapViewController : UIViewController

- (void)modelSetUp:(LineModel *)model;
@property (weak, nonatomic) IBOutlet MAMapView *mapView;

@end
