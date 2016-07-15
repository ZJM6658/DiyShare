//
//  ImageCollectionViewCell.h
//  GetTheWholeImage
//
//  Created by zhujiamin on 16/5/25.
//  Copyright © 2016年 zhujiamin@yaomaitong.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell_ShareItem : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

- (void)layoutUI:(NSMutableDictionary *)shareModel;

@end
