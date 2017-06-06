//
//  ViewController.m
//  SAPlatformShareManager
//
//  Created by 张炯 on 17/6/1.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "ViewController.h"

#import "SAPlatformShareManager.h"

@interface ViewController ()
- (IBAction)WXShareAction:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)WXShareAction:(id)sender {
    
    SAPlatformShareManager *manager = [SAPlatformShareManager shareInstanceManager];
    manager.contentType = SAShareContentTypePhoto;
    manager.shareScene = SAShareSceneTypeWXSceneSession;
    manager.contentModel.thumbImage = [UIImage imageNamed:@"111"];
    manager.contentModel.shareImage = [UIImage imageNamed:@"image"];
    [manager shareWithCallBack:^(int responseCode, NSString *responseMsg) {
        NSLog(@"---SendMessageToWXReq:-%d--%@---",responseCode,responseMsg);
    }];
    
}
@end
