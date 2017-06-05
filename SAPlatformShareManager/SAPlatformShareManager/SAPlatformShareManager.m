//
//  SAPlatformShareManager.m
//  PayTest
//
//  Created by 张炯 on 17/5/19.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "SAPlatformShareManager.h"
#import "WXApi.h"
#import "WXApiObject.h"
@interface SAPlatformShareManager()<WXApiDelegate>

@end

@implementation SAPlatformShareManager

+ (SAPlatformShareManager *)shareInstanceManager {
    static SAPlatformShareManager *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[SAPlatformShareManager alloc] init];
    });
    return shareManager;
}


#pragma mark -------
#pragma mark -------   微信分享

- (BOOL)isWXAppInstalled
{
    return [WXApi isWXAppInstalled];
}

- (void)WXShareTextContent:(NSString *)shareString scene:(SAShareSceneType)type{
    if (![self isWXAppInstalled]) {
        NSLog(@"----请安装微信----");
    }
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.text = shareString;
    req.bText = YES;
    switch (type) {
        case SAShareSceneTypeWXSceneSession:
            req.scene = WXSceneSession;
            break;
        case SAShareSceneTypeWXSceneTimeline:
            req.scene = WXSceneTimeline;
            break;
        case SAShareSceneTypeWXSceneFavorite:
            req.scene = WXSceneFavorite;
            break;
        default:
            break;
    }
    
    [WXApi sendReq:req];
}



#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXReq class]])
    {
        NSLog(@"---SendMessageToWXReq:-%d--%@---",resp.errCode,resp.errStr);
    }
}


@end
