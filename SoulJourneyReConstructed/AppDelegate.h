//
//  AppDelegate.h
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/14.
//  Copyright © 2017年 CH. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>
    
    //MARK: - NSUserDefualts的key
    ///当前用户名
@property   NSString *UD_CurrentUserName;
    ///当前的登录状态
@property   NSString *UD_LoginStatus;
    ///用户头像
@property    NSString *UD_UserImageUrl;
    
    ///屏幕宽度
@property    CGFloat screenW;
    ///屏幕高度
@property    CGFloat screenH;
    
    
    //MARK: -数据接口
    ///首页的头视图
@property    NSString *URL_Header;
    ///首页
@property    NSString *URL_HomePage;
    ///首页列表  area=china  area为参数名，值有china，asia，europe
@property    NSString *URL_HomeList;
    ///足迹列表  page:页数  per:每一页的个数
@property    NSString *URL_TrackList;
    ///首页详情 需拼接id.json
@property    NSString *URL_HomePageDetail;
    ///根据定位推荐附近景点 lat=30.66459165966441    lng=104.03882239208
@property    NSString *URL_NearList;
   ///某个范围内的 area=china   asia 亚洲  europe欧洲
@property    NSString *URL_AreaList;

@property (strong, nonatomic) UIWindow *window;



@end

