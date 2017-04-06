//
//  LineModel.m
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/18.
//  Copyright © 2017年 CH. All rights reserved.
//

#import "LineModel.h"

@implementation LineModel

@end

@implementation PointModel

@end

@implementation DayModel

+ (JSONKeyMapper *)keyMapper {
    
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"content" : @"description"
                                                                  }];
}

@end

@implementation InsirationModel

@end

@implementation POIModel

@end
