//
//  LineModel.h
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/18.
//  Copyright © 2017年 CH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "HomeListModel.h"

@interface CollectionsModel : JSONModel

@property NSInteger id;
@property NSString *topic;

@end

@interface POIModel : JSONModel

@property NSString *address;
@property NSString *blat;
@property NSString *blng;
@property NSInteger business_id;
@property NSInteger district_id;
@property NSString *h5_url;
@property NSInteger id;
@property NSString *lat;
@property NSString *lng;
@property NSString *name;
@property NSInteger youji_poi_id;

@end

@interface InsirationModel : JSONModel

@property NSArray<CollectionsModel *> *activity_collections;
@property NSString *address;
@property HomeListModel *destination;
@property NSInteger imbnd;
@property NSString *introduce;
@property PhotoModel *photo;
@property double *price;
@property double *time_cost;
@property NSString *topic;
@property NSString *visit_tip;

@end

@interface PointModel : JSONModel

@property NSInteger id;
@property InsirationModel *inspiration_activity;
@property BOOL is_custom;
@property NSString *position;
@property NSString *time_cost;
@property POIModel *poi;

@end

@interface DayModel : JSONModel

@property NSString *content; //!!!!
@property NSInteger id;
@property NSInteger plan_id;
@property NSArray<PointModel *> *points;
@property NSString *position;


@end

@interface LineModel : JSONModel

@property NSString *created_at;
@property NSArray<DayModel *> *days;
@property NSInteger days_count;
@property HomeListModel *destination;
@property NSInteger destination_id;
@property NSInteger id;
@property PhotoModel *photo;
@property NSString *title;


@end














