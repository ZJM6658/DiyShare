//
//  ViewController.m
//  UMengDiyShare
//
//  Created by zhujiamin on 16/7/10.
//  Copyright © 2016年 zhujiamin@yaomaitong.cn. All rights reserved.
//

#import "ViewController.h"
#import "V_MyShareSheet.h"

@interface ViewController () {
    V_MyShareSheet *_myShareSheet;
}

@end

@implementation ViewController

- (instancetype)init {
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.title = @"UMengDiyShare";
    }
    return self;
}


- (void)nslogString:(NSString *)string {
    
    NSMutableArray * array=[NSMutableArray arrayWithArray:[string   componentsSeparatedByString:@","]];
    NSString *resultStr=[array componentsJoinedByString:@""];
    
//    for (int i = 2; i <= resultStr.length; i++) {
//        NSLog(@"string=%@",[resultStr substringToIndex:i]);
//    }
//    for (int i = 1; i <= resultStr.length - 2; i++) {
//        NSLog(@"string==%@",[resultStr substringFromIndex:i]);
//    }
    
    for (NSInteger i = 0; i <= resultStr.length - 2; i++) {
        for (NSInteger j = 2; j <= resultStr.length - i; j++) {
            NSRange range = NSMakeRange(i, j);
            NSString *result = [resultStr substringWithRange:range];
            NSLog(@"string==%@",result);
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"不带举报的分享"
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(showShareView:)];
    self.navigationItem.leftBarButtonItem.tag = 100;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"带举报分享"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(showShareView:)];
    self.navigationItem.rightBarButtonItem.tag = 101;
}

- (void)showShareView:(UIBarButtonItem *)sender {
    NSInteger viewtype = sender.tag - 100;
    _myShareSheet = [[V_MyShareSheet alloc]initWithViewType:viewtype];
    _myShareSheet.actionVC = self;
    _myShareSheet.ObjectNil = ^{
        _myShareSheet = nil;
    };
    [_myShareSheet show];
}

- (void)shareToWeChatAction {
    NSLog(@"微信分享");
    
}

- (void)shareToWeChatFriendAction {
    NSLog(@"微信朋友圈分享");
    
}

- (void)shareTosmsAction {
    NSLog(@"短信分享");
    
}

- (void)goToreportAction {
    NSLog(@"举报操作");
    
}

@end
