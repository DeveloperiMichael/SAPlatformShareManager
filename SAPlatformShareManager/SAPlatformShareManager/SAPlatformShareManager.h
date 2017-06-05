//
//  SAPlatformShareManager.h
//  PayTest
//
//  Created by 张炯 on 17/5/19.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, SAShareSceneType) {
    SAShareSceneTypeToQQFriends = 0,
    SAShareSceneTypeToQQZone,
    SAShareSceneTypeWXSceneSession,
    SAShareSceneTypeWXSceneTimeline,
    SAShareSceneTypeWXSceneFavorite
};


typedef NS_ENUM(NSInteger, SAShareContentType) {
    SAShareContentTypeText = 0,
    SAShareContentTypePhoto,
    SAShareContentTypeLink,
    SAShareContentTypeMusic,
    SAShareContentTypeVideo,
    SAShareContentTypeAppMessage,
    SAShareContentTypeGif,
    SAShareContentTypeNotGif,
};

@interface SAPlatformShareManager : NSObject

/**
 实例化一个分享管理对象
 
 @return 分享管理对象
 */

+ (SAPlatformShareManager *)shareInstanceManager;

/** 分享给好友、朋友圈 */
@property (nonatomic, assign) SAShareSceneType scene;

/** 分享内容类型 */
@property (nonatomic, assign) SAShareContentType contentType;


/// 微信分享


/**
 微信text分享

 @param shareString 分享text内容
 @param type 分享类型
 */
- (void)WXShareTextContent:(NSString *)shareString scene:(SAShareSceneType)type;



@end
