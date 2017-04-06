//
//  HomeListModel.h
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/17.
//  Copyright © 2017年 CH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "BannerModel.h"
@interface HomeListModel : JSONModel

@property NSInteger district_id;
@property NSInteger has_airport;
@property NSInteger id;
@property NSInteger is_in_china;
@property NSString *lat;
@property NSString *lng;
@property NSInteger level;
@property NSString *name;
@property NSString *name_en;
@property NSString *path;
@property PhotoModel *photo;
@property NSInteger published;
@property NSInteger score;
@property NSString<Optional> *summary;
@property NSString *tip;
@property NSString *title;
@property NSString *visit_tip;

@end
