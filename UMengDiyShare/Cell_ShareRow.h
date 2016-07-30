//
//  Cell_ShareRow.h
//  UMengDiyShare
//
//  Created by zhujiamin on 16/7/13.
//  Copyright © 2016年 zhujiamin@yaomaitong.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cell_ShareItem.h"
#import "ViewController.h"

@interface Cell_ShareRow : UITableViewCell

@property (nonatomic, weak) id actionVC;

- (void)layoutCellWithData:(NSArray *)dataArray;

@end
