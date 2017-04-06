//
//  DataBase.h
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/30.
//  Copyright © 2017年 CH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrackLineModel.h"
#import "LineModel.h"

@interface DataBase : NSObject

+ (instancetype)sharedDataBase;

-(BOOL)isExist:(NSString *)title;
-(void)addTrack:(LineModel *)model :(NSString *)photoUrl;
-(NSMutableArray<TrackLineModel *> *)getAllTracks;
-(BOOL)deleteTrack:(NSString *)title;

@end
