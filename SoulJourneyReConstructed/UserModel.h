//
//  UserModel.h
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/19.
//  Copyright © 2017年 CH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface UserModel : JSONModel

@property NSString *gender;
@property NSInteger id;
@property NSString *name;
@property NSString *photo_url;

@end
