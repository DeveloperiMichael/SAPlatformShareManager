//
//  SAPlatformShareManager.m
//  PayTest
//
//  Created by 张炯 on 17/5/19.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "SAPlatformShareManager.h"

@interface SAPlatformShareManager()<WXApiDelegate>

@property (nonatomic, copy) SAShareCallBack callBackBlock;

@end

@implementation SAShareContentModel



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


- (void)shareWithCallBack:(SAShareCallBack)block {
    
    self.callBackBlock = block;
    
    switch ([SAPlatformShareManager shareInstanceManager].shareScene) {
        case SAShareSceneTypeWXSceneTimeline:
        case SAShareSceneTypeWXSceneSession:
        case SAShareSceneTypeWXSceneFavorite:
        {
            if (![self isWXAppInstalled]) {
                NSLog(@"----请安装微信----");
                return;
            }
            
            [self WXShare];
        }
            
            break;
            
        default:
            break;
    }
}


#pragma mark -------
#pragma mark -------   微信分享

- (BOOL)isWXAppInstalled
{
    return [WXApi isWXAppInstalled];
}



- (void)WXShare {
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    switch ([SAPlatformShareManager shareInstanceManager].shareScene) {
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
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = _contentModel.title;
    message.description = _contentModel.description;
    [message setThumbImage:_contentModel.thumbImage];
    
    switch ([SAPlatformShareManager shareInstanceManager].contentType) {
        case SAShareContentTypeText:
        {
            req.text = _contentModel.shareString;
            req.bText = YES;

        }
            break;
        case SAShareContentTypePhoto:
        {
            
            WXImageObject *ext = [WXImageObject object];
            ext.imageData = UIImagePNGRepresentation(_contentModel.shareImage);
            message.mediaObject = ext;
            
            req.bText = NO;
            
        }
            break;
        case SAShareContentTypeLink:
        {
            
            
            WXWebpageObject *ext = [WXWebpageObject object];
            ext.webpageUrl = _contentModel.linkUrl;
            message.mediaObject = ext;
            
            req.bText = NO;
        }
            break;
        case SAShareContentTypeMusic:
        {
            WXMusicObject *ext = [WXMusicObject object];
            ext.musicUrl = @"";
            ext.musicDataUrl = _contentModel.musicUrl;
            message.mediaObject = ext;
            
            req.bText = NO;

        }
            break;
        case SAShareContentTypeVideo:
        {
            WXVideoObject *ext = [WXVideoObject object];
            ext.videoUrl = _contentModel.videoUrl;
            message.mediaObject = ext;
            
            req.bText = NO;
        }
            break;
        default:
            break;
    }
    
    req.message = message;
    [WXApi sendReq:req];
}


#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        if (self.callBackBlock) {
            self.callBackBlock(resp.errCode,resp.errStr);
        }
        [SAPlatformShareManager shareInstanceManager].contentModel = nil;
    }
    
    
}

- (BOOL)WXShareHandleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:[SAPlatformShareManager shareInstanceManager]];
}

+ (BOOL)WXShareRegisterAppWithAppId:(NSString *)appId;
{
    return [WXApi registerApp:appId];
}





#pragma mark - 
#pragma mark -  QQ分享






















+ (BOOL)handleShareOpenUrl:(NSURL *)url {
    
    if([url.scheme hasPrefix:@"wx"])//微信
    {
        return [[SAPlatformShareManager shareInstanceManager] WXShareHandleOpenURL:url];
    }
    
    return NO;
}




- (SAShareContentModel *)contentModel {
    if (!_contentModel) {
        _contentModel = [[SAShareContentModel alloc] init];
    }
    return _contentModel;
}



@end
