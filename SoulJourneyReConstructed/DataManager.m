//
//  DataManager.m
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/16.
//  Copyright © 2017年 CH. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager


static DataManager *instance = nil;


+ (DataManager *)sharedDataManager {
    
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        
        instance = [[self alloc] init];
        
    });
    return instance;
}

@end
