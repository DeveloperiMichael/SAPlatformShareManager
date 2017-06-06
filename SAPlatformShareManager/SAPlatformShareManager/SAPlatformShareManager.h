//
//  SAPlatformShareManager.h
//  PayTest
//
//  Created by 张炯 on 17/5/19.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import "WXApiObject.h"

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


typedef void(^SAShareCallBack)(int responseCode, NSString *responseMsg);

///分享内容的模型

@interface SAShareContentModel : NSObject

@property (nonatomic, copy) NSString *shareString;    //分享的文字
@property (nonatomic, strong) UIImage *thumbImage;    //缩略图
@property (nonatomic, strong) UIImage *shareImage;    //分享的图片
@property (nonatomic, copy) NSString *linkUrl;        //分享的链接
@property (nonatomic, copy) NSString *musicUrl;       //音乐分享的链接
@property (nonatomic, copy) NSString *videoUrl;       //视频分享的链接
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *title;

@end





@interface SAPlatformShareManager : NSObject

/**
 实例化一个分享管理对象
 
 @return 分享管理对象
 */

+ (SAPlatformShareManager *)shareInstanceManager;

/** 分享给好友、朋友圈 */
@property (nonatomic, assign) SAShareSceneType shareScene;

/** 分享内容类型 */
@property (nonatomic, assign) SAShareContentType contentType;

/** 分享内容 */
@property (nonatomic, strong) SAShareContentModel *contentModel;

#pragma mark - 
#pragma mark - 微信分享

- (void)shareWithCallBack:(SAShareCallBack)block;

+ (BOOL)WXShareRegisterAppWithAppId:(NSString *)appId;




















+ (BOOL)handleShareOpenUrl:(NSURL *)url;

@end





