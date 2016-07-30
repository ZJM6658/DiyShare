//
//  V_MyShareSheet.m
//  UMengDiyShare
//
//  Created by zhujiamin on 16/7/13.
//  Copyright © 2016年 zhujiamin@yaomaitong.cn. All rights reserved.
//

#import "V_MyShareSheet.h"
//#import "M_Share.h"

@interface V_MyShareSheet ()<UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tableView;
    NSMutableArray *_dataSource;
    UILabel *_backLabel;
}

@end

@implementation V_MyShareSheet

#pragma mark - initialize
- (instancetype)initWithViewType:(NSInteger)viewtype {
    self= [super initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    if (self) {
        _dataSource = [[NSMutableArray alloc]init];
        [self layoutUI];
        [self generateDataWithViewType:viewtype];
    }
    return self;
}

#pragma mark - layoutUI
- (void)layoutUI {
    //灰色背景
    _backLabel = [[UILabel alloc]initWithFrame:self.frame];
    _backLabel.backgroundColor = [UIColor blackColor];
    _backLabel.alpha = 0.0;
    [UIView animateWithDuration:0.3 animations:^{
        _backLabel.alpha = 0.4;
    }];
    _backLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tagZer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancel)];
    [_backLabel addGestureRecognizer:tagZer];
    [self addSubview:_backLabel];
}

#pragma mark - outside methods
/**
 *  添加view到window上
 */
- (void)show{
    [[[UIApplication sharedApplication]keyWindow]addSubview:self];
}

#pragma mark - private methods
/**
 *  退出动画
 */
- (void)cancel{
    [UIView animateWithDuration:0.3 animations:^{
        _backLabel.alpha = 0.0;
        CGRect rect = _tableView.frame;
        rect.origin.y = self.frame.size.height;
        _tableView.frame = rect;
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
    
    setObjectNil block = self.ObjectNil;
    //block现在是本地不可变的
    if (block) {
        block();
    }
}

/**
 *  构造数据源+配置控件属性
 *
 *  @return nil
 */
- (void)generateDataWithViewType:(NSInteger)viewtype {
    //使用模型的构造方法
//        M_Share *wechatModel = [[M_Share alloc]init];
//        wechatModel.title = @"微信";
//        wechatModel.imageName = @"wechat_icon";
//        wechatModel.selector = @selector(shareToWeChatAction);
//        [sectionOne addObject:wechatModel];
//    
//        [_dataSource addObject:sectionOne];
    
    
    BOOL isWXInstall = YES;//= [WXApi isWXAppInstalled];
    NSMutableArray *sectionOne = [[NSMutableArray alloc]init];
    if (isWXInstall) {
        NSMutableDictionary *wechatDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"imageName":@"wechat_icon", @"title":@"微信", @"actionName":@"shareToWeChatAction"}];
        NSMutableDictionary *wechatFriendDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"imageName":@"wechat_timeline_icon", @"title":@"微信朋友圈", @"actionName":@"shareToWeChatFriendAction"}];
        [sectionOne addObject:wechatDic];
        [sectionOne addObject:wechatFriendDic];
    }

    //短信分享
    NSMutableDictionary *smsDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"imageName":@"sms_icon", @"title":@"短信",@"actionName":@"shareTosmsAction"}];
    [sectionOne addObject:smsDic];
    
    //复制链接
    NSMutableDictionary *copyDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"imageName":@"copy_icon", @"title":@"复制链接",@"actionName":@"copyUrlAction"}];
    [sectionOne addObject:copyDic];
    
    [_dataSource addObject:sectionOne];

    //举报按钮
    if (viewtype) {
        NSMutableArray *sectionTwo = [[NSMutableArray alloc]init];
        NSMutableDictionary *reportDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"imageName":@"img_report", @"title":@"举报", @"actionName":@"goToreportAction"}];
        [sectionTwo addObject:reportDic];
        [_dataSource addObject:sectionTwo];
    }
    
    CGFloat tableHeight = viewtype?240+40:120+40;
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, tableHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];

        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [self addSubview:_tableView];
    }
    
    //根据UI需求添加分割线
    if (viewtype) {
        UIView * separator = [[UIView alloc] initWithFrame:CGRectMake(0, 120, self.frame.size.width, 1)];
        separator.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1];
        [_tableView addSubview:separator];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = _tableView.frame;
        rect.origin.y = self.frame.size.height - tableHeight;// - 64;
        _tableView.frame = rect;
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Cell_ShareRow *cell = [tableView dequeueReusableCellWithIdentifier:@"ZJMCELL"];
    if (!cell) {
        cell = [[Cell_ShareRow alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ZJMCELL"];
        cell.separatorInset = UIEdgeInsetsZero;
        cell.actionVC = self.actionVC;
    }
    [cell layoutCellWithData:_dataSource[indexPath.section]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *headLabel = [[UILabel alloc]init];
    headLabel.font = [UIFont systemFontOfSize:12];
    if (section == 0) {
        headLabel.text = @"   分享到";
    } else {
        headLabel.text = @"   举报";
    }
    return headLabel;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1 || _dataSource.count == 1) {
        UIButton *footButton = [[UIButton alloc]init];
        [footButton setTitle:@"取消" forState:UIControlStateNormal];
        [footButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [footButton setBackgroundColor:[UIColor whiteColor]];
        [footButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        return footButton;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 101;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1 || _dataSource.count == 1) {
        return 40;
    }
    return CGFLOAT_MIN;
}

//使用模型需要实现或者声明带有以下方法的协议
//- (void)shareToWeChatAction {
//    NSLog(@"微信分享");
//    
//}
//
//- (void)shareToWeChatFriendAction {
//    NSLog(@"微信朋友圈分享");
//    
//}
//
//- (void)shareTosmsAction {
//    NSLog(@"短信分享");
//    
//}
//
//- (void)goToreportAction {
//    NSLog(@"举报操作");
//    
//}

@end
