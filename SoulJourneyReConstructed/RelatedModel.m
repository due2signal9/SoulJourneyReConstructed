//
//  RelatedModel.m
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/19.
//  Copyright © 2017年 CH. All rights reserved.
//

#import "RelatedModel.h"

@implementation RelatedModel

@end

@implementation RelatedContentModel

+ (JSONKeyMapper *)keyMapper {
    
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"textContent" : @"description"
                                                                 }];
}

@end
