//
//  V_MyShareSheet.h
//  UMengDiyShare
//
//  Created by zhujiamin on 16/7/13.
//  Copyright © 2016年 zhujiamin@yaomaitong.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cell_ShareRow.h"
#import "WXApi.h"

typedef void (^setObjectNil) (void);

@interface V_MyShareSheet : UIView

@property (nonatomic, copy) setObjectNil ObjectNil;
@property (nonatomic, weak) id actionVC;

- (instancetype)initWithViewType:(NSInteger)viewtype;
- (void)show;

@end
