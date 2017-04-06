//
//  TrackModel.h
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/19.
//  Copyright © 2017年 CH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "HomeModel.h"
#import "UserModel.h"

@interface DistrictModel : JSONModel

@property NSInteger destination_id;
@property NSInteger id;
@property NSString *is_in_china;
@property NSString *is_valid_destination;
@property NSString *lat;
@property NSString *lng;
@property NSString *name;
@property NSString *name_en;
@property NSString *path;
@property NSString *published;
@property NSInteger *user_activities_count;

@end

@interface TrackModel : JSONModel

@property NSArray<PhotoModel *> *contents;
@property NSString *created_at;
@property NSString *content;

//district id
@property NSInteger district_id;
@property NSArray<DistrictModel *> *districts;
@property NSInteger id;
@property NSInteger likes_count;
@property NSString *topic;
@property UserModel *user;
@property NSInteger parent_district_count;
@property NSInteger parent_district_id;

@end
