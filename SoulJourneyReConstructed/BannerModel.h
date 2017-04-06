//
//  BannerModel.h
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/16.
//  Copyright © 2017年 CH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface PhotoModel : JSONModel

@property NSString<Optional> *caption;
@property NSInteger width;
@property NSInteger height;
@property NSString *photo_url;

@end

@interface BannerModel : JSONModel
@property NSString *advert_type;
@property NSInteger id;
@property NSString *market;
@property NSString *open_in_browser;
@property NSInteger target_id;
@property NSString *topic;
@property (strong, atomic)PhotoModel *photo;

@end

