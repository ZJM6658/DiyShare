//
//  MD_OurShareSheetView.h
//  webViewText
//
//  Created by zhujiamin on 16/1/15.
//  Copyright © 2016年 zhujiamin@yaomaitong.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCRW        [UIApplication sharedApplication].keyWindow.bounds.size.width
#define SCRH        [UIApplication sharedApplication].keyWindow.bounds.size.height

typedef void (^setObjectnil) (void);
@protocol V_BottomShareDelegate <NSObject>
@required

- (void)shareToWeChatAction;
- (void)shareToWeChatFriendAction;
- (void)shareTosmsAction;
- (void)goToreportAction;

@end

@interface V_BottomShare : UIView 

@property (nonatomic,weak) id<V_BottomShareDelegate> delegate;
@property (nonatomic) NSInteger viewType;//0-无举报  1-有举报
@property (nonatomic, strong) UIButton *weChatButton;
@property (nonatomic, strong) UIButton *weChatFriendButton;
@property (nonatomic, strong) UIButton *smsButton;
@property (nonatomic, strong) UIButton *reportButton;
@property (nonatomic, copy) setObjectnil Objectnil;

- (instancetype)initWithViewType:(NSInteger)viewtype;
- (void)show;

@end

