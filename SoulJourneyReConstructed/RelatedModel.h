//
//  RelatedModel.h
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/19.
//  Copyright © 2017年 CH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "BannerModel.h"
#import "HomeListModel.h"
#import "UserModel.h"

@interface RelatedContentModel : JSONModel

@property NSArray<PhotoModel *> *contents;
@property NSInteger district_id;
@property NSArray<HomeListModel *> *districts;
@property NSInteger id;
@property NSString *summary;
@property NSString *topic;
@property NSString *textContent;
@property UserModel *user;

@end

@interface RelatedModel : JSONModel

@property NSString *button_text;
@property NSArray<RelatedContentModel *> *models;

@end
