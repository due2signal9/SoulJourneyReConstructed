//
//  OtherViewController.h
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/25.
//  Copyright © 2017年 CH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherViewController : UIViewController<UIWebViewDelegate>

@property NSString *url;
@property NSString *navigationTitle;

- (void)beginLoading;

@end
