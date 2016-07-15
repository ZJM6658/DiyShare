
//
//  MD_OurShareSheetView.m
//  webViewText
//
//  Created by zhujiamin on 16/1/15.
//  Copyright © 2016年 zhujiamin@yaomaitong.cn. All rights reserved.
//

#import "V_BottomShare.h"
#import "UMSocial.h"
#import "WXApi.h"

#define CHAT_BUTTON_SIZE 55
#define LEFTX 20//间距

#define INSETS 15//间距

#define FONT_12     [UIFont systemFontOfSize:12]
#define FONT_14     [UIFont systemFontOfSize:14]

@interface V_BottomShare () {
    UIView *butView;
    UIScrollView *shareScroll;
    UIView *backLabel;
    UICollectionView *collectView;
}

@end

@implementation V_BottomShare

- (instancetype)initWithViewType:(NSInteger)viewtype{
    CGRect frame = [UIApplication sharedApplication].keyWindow.bounds;
    if (self == [super initWithFrame:frame]) {
        self.frame = frame;
        self.viewType = viewtype;
        [self layoutUI];
    }
    return self;
}

- (void)cancel{
    [UIView animateWithDuration:0.3 animations:^{
        backLabel.alpha = 0.0;
        CGRect rect = butView.frame;
        rect.origin.y = self.frame.size.height;
        butView.frame = rect;
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
    
    setObjectnil block = self.Objectnil;
    //block现在是本地不可变的
    if (block)
    {
        block();
    }
}

- (void)show{
    [[[UIApplication sharedApplication]keyWindow]addSubview:self];
}

//分享scroll
- (void)layoutShareScroll{
    CGFloat insets = (SCRW - 5 * CHAT_BUTTON_SIZE) / 6;
    
    UILabel *shareLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 10, 100, 20)];
    shareLabel.text = @"分享到";
    shareLabel.font = FONT_14;
    shareLabel.textColor = [UIColor blackColor];
    [butView addSubview:shareLabel];
    
    shareScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, SCRW, CHAT_BUTTON_SIZE + 35)];
//    shareScroll.backgroundColor = [UIColor orangeColor];
    
    _weChatButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [_weChatButton setFrame:CGRectMake(LEFTX, 10, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
    [_weChatButton setImage:[UIImage imageNamed:@"wechat_icon"] forState:UIControlStateNormal];
    [_weChatButton setTitle:@"微信好友" forState:UIControlStateNormal];
    [_weChatButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _weChatButton.titleLabel.font = FONT_12;
    _weChatButton.titleLabel.numberOfLines = 0;
    _weChatButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    _weChatButton.imageEdgeInsets = UIEdgeInsetsMake( 0, 0, 0, 0);
    _weChatButton.titleEdgeInsets = UIEdgeInsetsMake(CHAT_BUTTON_SIZE, -CHAT_BUTTON_SIZE - 10, -_weChatButton.titleLabel.frame.size.height - 20, -10);//设置title在button上的位置（上top，左left，下bottom，右right
    
    [_weChatButton addTarget:self action:@selector(weChatButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    _weChatFriendButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [_weChatFriendButton setFrame:CGRectMake(insets + CGRectGetMaxX(_weChatButton.frame), 10, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
    [_weChatFriendButton setImage:[UIImage imageNamed:@"wechat_timeline_icon"] forState:UIControlStateNormal];
    [_weChatFriendButton setTitle:@"朋友圈" forState:UIControlStateNormal];
    [_weChatFriendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _weChatFriendButton.titleLabel.font = FONT_12;
    _weChatFriendButton.titleLabel.numberOfLines = 0;
    _weChatFriendButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    _weChatFriendButton.titleEdgeInsets = UIEdgeInsetsMake(CHAT_BUTTON_SIZE, -CHAT_BUTTON_SIZE, -_weChatFriendButton.titleLabel.frame.size.height - 20, 0);
    
    [_weChatFriendButton addTarget:self action:@selector(weChatFriendButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    //短信分享
    _smsButton =[UIButton buttonWithType:UIButtonTypeCustom];
    BOOL isWXInstall = YES;//[WXApi isWXAppInstalled];
    if (isWXInstall) {
        [_smsButton setFrame:CGRectMake(insets + CGRectGetMaxX(_weChatFriendButton.frame), 10, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
        [shareScroll addSubview:_weChatButton];
        [shareScroll addSubview:_weChatFriendButton];
    } else {
        [_smsButton setFrame:CGRectMake(LEFTX, 10, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
    }
    
    [_smsButton setImage:[UIImage imageNamed:@"sms_icon"] forState:UIControlStateNormal];
    
    [_smsButton setTitle:@"短信" forState:UIControlStateNormal];
    [_smsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _smsButton.titleLabel.font = FONT_12;
    _smsButton.titleLabel.numberOfLines = 0;
    _smsButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _smsButton.titleEdgeInsets = UIEdgeInsetsMake(CHAT_BUTTON_SIZE, -CHAT_BUTTON_SIZE, -_smsButton.titleLabel.frame.size.height - 20, 0);
    
    [_smsButton addTarget:self action:@selector(smsButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [shareScroll addSubview:_smsButton];
    
    [butView addSubview:shareScroll];
    //方法不能添加  还是使用字符串吧 runtime的response方法去组合action_名字
}

- (void)layoutUI{
    //灰色背景
    backLabel = [[UILabel alloc]initWithFrame:self.frame];
    backLabel.backgroundColor = [UIColor blackColor];
    backLabel.alpha = 0.0;
    [UIView animateWithDuration:0.3 animations:^{
        backLabel.alpha = 0.4;
    }];
    backLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tagZer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancel)];
    [backLabel addGestureRecognizer:tagZer];
    [self addSubview:backLabel];
    
    //载体
    butView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCRW, 0)];
    [self layoutShareScroll];//添加分享UI
    UIButton *cancelBut = [[UIButton alloc]init];
    if (self.viewType) {
        //举报分割线
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(3, CGRectGetMaxY(shareScroll.frame), SCRW - 6, 1)];
        lineLabel.backgroundColor = [UIColor grayColor];
        [butView addSubview:lineLabel];

        _reportButton =[UIButton buttonWithType:UIButtonTypeCustom];
        [_reportButton setFrame:CGRectMake(LEFTX, CGRectGetMaxY(lineLabel.frame) + 15, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
        [_reportButton setImage:[UIImage imageNamed:@"img_report"] forState:UIControlStateNormal];
        
        [_reportButton setTitle:@"举报" forState:UIControlStateNormal];
        [_reportButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _reportButton.titleLabel.font = FONT_12;
        _reportButton.titleLabel.numberOfLines = 0;
        _reportButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _reportButton.titleEdgeInsets = UIEdgeInsetsMake(CHAT_BUTTON_SIZE, -CHAT_BUTTON_SIZE, -_reportButton.titleLabel.frame.size.height - 20, 0);
        
        [_reportButton addTarget:self action:@selector(reportButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [butView addSubview:_reportButton];
        [cancelBut setFrame:CGRectMake(0, CGRectGetMaxY(_reportButton.frame) + 25, self.frame.size.width, 40)];
    } else {
        [cancelBut setFrame:CGRectMake(0, CGRectGetMaxY(shareScroll.frame), self.frame.size.width, 40)];
    }
    
    //取消按钮
    [cancelBut setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelBut.backgroundColor = [UIColor whiteColor];
    [cancelBut addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [butView addSubview:cancelBut];
    
    [butView setFrame:CGRectMake(0, self.frame.size.height, SCRW, CGRectGetMaxY(cancelBut.frame))];
    butView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    
    [self addSubview:butView];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = butView.frame;
        rect.origin.y = SCRH - butView.frame.size.height;// - 64;
        butView.frame = rect;
    }];

}

//分享到微信
- (void)weChatButtonAction{
    if(_delegate && [_delegate respondsToSelector:@selector(shareToWeChatAction)]){
        [_delegate shareToWeChatAction];
    }
}

//分享到微信朋友圈
- (void)weChatFriendButtonAction{
    if(_delegate && [_delegate respondsToSelector:@selector(shareToWeChatFriendAction)]){
        [_delegate shareToWeChatFriendAction];
    }
}

//分享到短信
- (void)smsButtonAction{
    if(_delegate && [_delegate respondsToSelector:@selector(shareTosmsAction)]){
        [_delegate shareTosmsAction];
    }
}

//举报
- (void)reportButtonAction{
    if(_delegate && [_delegate respondsToSelector:@selector(goToreportAction)]){
        [_delegate goToreportAction];
    }
}

@end
