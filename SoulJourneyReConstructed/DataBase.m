//
//  DataBase.m
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/30.
//  Copyright © 2017年 CH. All rights reserved.
//

#import "DataBase.h"
#import <FMDB.h>
#import <KVNProgress.h>

static DataBase *_DBCtl = nil;

@interface DataBase() {
    
    FMDatabase *_db;
}

@end

@implementation DataBase

+(instancetype)sharedDataBase {
    
    if (_DBCtl == nil) {
        
        _DBCtl = [[DataBase alloc] init];
        [_DBCtl initDataBase];
    }
    return _DBCtl;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone {
    if (_DBCtl == nil) {
        
        _DBCtl = [super allocWithZone:zone];
    }
    
    return _DBCtl;
}

-(id)mutableCopyWithZone:(NSZone *)zone {
    
    return self;
}

- (void)initDataBase {
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"TrackModel.db"];
    _db = [FMDatabase databaseWithPath:filePath];
    
    if ([_db open]) {
        
        NSString *modelSql = @"CREATE TABLE 'tracktable' ('iid' VARCHAR(255) not null, 'title' VARCHAR(255) not null, 'photo_url' VARCHAR(255) not null, 'date' VARCHAR(255) not null, 'daycount' INTEGER)";
        [_db executeUpdate:modelSql];
        [_db close];
    }
}

-(BOOL)isExist:(NSString *)title {
    
    //NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:5];
    
    [_db open];
    FMResultSet *res = [_db executeQuery:@"SELECT COUNT(title) AS countNum FROM tracktable WHERE title = ?",title];
    if (res == nil) {
        
        [KVNProgress showErrorWithStatus:[NSString stringWithFormat:@"%@", _db.lastErrorMessage]];
    }
    while([res next]) {
        
        NSInteger count = [res intForColumn:@"countNum"];
        if (count > 0) {
            
            [res close];
            [_db close];
            return YES;
        } else {
            
            [res close];
            [_db close];
            return NO;
        }
    }
    return YES;
}

-(NSMutableArray<TrackLineModel *> *)getAllTracks {
    
    NSMutableArray<TrackLineModel *> *tmps;
    if ([_db open]) {
        
        tmps = [NSMutableArray arrayWithCapacity:5];
        FMResultSet *res = [_db executeQuery:@"SELECT * FROM tracktable"];
        while ([res next]) {
            
            TrackLineModel *model = [[TrackLineModel alloc] init];
            model.photo_url = [res stringForColumn:@"photo_url"];
            model.title = [res stringForColumn:@"title"];
            model.id = [res stringForColumn:@"iid"];
            model.date = [res stringForColumn:@"date"];
            model.daycount = [res intForColumn:@"daycount"];
            [tmps addObject:model];
        }
        [res close];
        [_db close];
    }
    return tmps;
}

-(void)addTrack:(LineModel *)model :(NSString *)photoUrl {
    
    if (model == nil) {
        
        [KVNProgress showErrorWithStatus:@"行程不存在"];
        return;
    }
    
    NSString *title = model.title;
    NSString *photo_url = photoUrl;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *date = [formatter stringFromDate:[NSDate date]];
    NSInteger daycount = model.days_count;
    NSString *iid = [NSString stringWithFormat:@"%ld", (long)model.destination_id];
    
    if ([_db open]) {
        
        BOOL a = [_db executeUpdate:@"INSERT INTO tracktable(iid,title,photo_url,date,daycount) VALUES (?,?,?,?,?)", iid, title, photo_url, date, @(daycount)];
        if (!a) {
            
            NSLog(@"%@", _db.lastErrorMessage);
        }
        [_db close];
    }
}

-(BOOL)deleteTrack:(NSString *)title {
    
    //@"2017-04-03 20:53:53"
    if (title == nil) {
        
        NSLog(@"");
        
    }
    
    BOOL isSuccess = NO;
    if ([_db open]) {
        
        isSuccess = [_db executeUpdate:@"DELETE FROM tracktable WHERE title = ?", title];
    }
    if (isSuccess) {
        
        return isSuccess;
    } else {
        
        NSLog(@"%@", _db.lastErrorMessage);
        return NO;
    }
}

@end







