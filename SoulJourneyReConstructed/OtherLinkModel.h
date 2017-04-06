//
//  OtherLinkModel.h
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/19.
//  Copyright © 2017年 CH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface OtherLinkModel : JSONModel

@property NSString *photo_url;
@property NSString *title;
@property NSString *type;
@property NSString<Optional> *url;

@end
