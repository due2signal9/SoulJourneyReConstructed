//
//  TrackModel.m
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/19.
//  Copyright © 2017年 CH. All rights reserved.
//

#import "TrackModel.h"

@implementation DistrictModel

@end

@implementation TrackModel

+(JSONKeyMapper *)keyMapper {
    
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"content":@"description"
                                                                  }];
}

@end
