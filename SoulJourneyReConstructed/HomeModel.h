//
//  HomeModel.h
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/17.
//  Copyright © 2017年 CH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "HomeListModel.h"

@interface HomeModel : JSONModel

@property NSString<Optional> *button_text;
@property NSString *name;
@property NSString *region;
@property NSArray *destinations;

@end
