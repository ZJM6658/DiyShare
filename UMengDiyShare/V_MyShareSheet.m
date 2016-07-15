//
//  V_MyShareSheet.m
//  UMengDiyShare
//
//  Created by zhujiamin on 16/7/13.
//  Copyright © 2016年 zhujiamin@yaomaitong.cn. All rights reserved.
//

#import "V_MyShareSheet.h"

@interface V_MyShareSheet ()<UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tableView;
    NSMutableArray *_dataSource;
    UILabel *_backLabel;
}

@end

@implementation V_MyShareSheet

- (instancetype)initWithViewType:(NSInteger)viewtype {
    self= [super initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    if (self) {
        _dataSource = [[NSMutableArray alloc]init];
        [self layoutUI];
        [self generateDataWithViewType:viewtype];
    }
    return self;
}

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

//创建数据源
- (void)generateDataWithViewType:(NSInteger)viewtype {
    
//    NSMutableArray *imageArray = [[NSMutableArray alloc]init];
//    for (int i = 0; i < 9 ; i ++) {
//        NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:@{@"imageName":@"wechat_icon", @"title":@"微信朋友圈"}];
//        [imageArray addObject:dic];
//    }
//    [_dataSource addObject:imageArray];

    BOOL isWXInstall = YES;//= [WXApi isWXAppInstalled];
    NSMutableArray *sectionOne = [[NSMutableArray alloc]init];
    if (isWXInstall) {
        NSMutableDictionary *wechatDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"imageName":@"wechat_icon", @"title":@"微信", @"actionName":@"shareToWeChatAction"}];
        NSMutableDictionary *wechatFriendDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"imageName":@"wechat_timeline_icon", @"title":@"微信朋友圈", @"actionName":@"shareToWeChatFriendAction"}];
        [sectionOne addObject:wechatDic];
        [sectionOne addObject:wechatFriendDic];
    }
    
    NSMutableDictionary *smsDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"imageName":@"sms_icon", @"title":@"短信",@"actionName":@"shareTosmsAction"}];
    [sectionOne addObject:smsDic];
    [_dataSource addObject:sectionOne];
    
    if (viewtype) {
        NSMutableArray *sectionTwo = [[NSMutableArray alloc]init];
        NSMutableDictionary *reportDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"imageName":@"img_report", @"title":@"举报", @"actionName":@"goToreportAction"}];
        [sectionTwo addObject:reportDic];
        [_dataSource addObject:sectionTwo];
    }
    
    CGFloat tableHeight = viewtype?240:120;
    
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

- (void)show{
    [[[UIApplication sharedApplication]keyWindow]addSubview:self];
}

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
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 101;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

@end
