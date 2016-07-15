//
//  ImageCollectionViewCell.m
//  GetTheWholeImage
//
//  Created by zhujiamin on 16/5/25.
//  Copyright © 2016年 zhujiamin@yaomaitong.cn. All rights reserved.
//

#import "Cell_ShareItem.h"

@implementation Cell_ShareItem

- (void)layoutUI:(NSMutableDictionary *)shareModel {
    if (!_imageView) {
        [self.contentView addSubview:self.imageView];
    }
    _imageView.image = [UIImage imageNamed:shareModel[@"imageName"]];
    
    if (!_titleLabel) {
        [self.contentView addSubview:self.titleLabel];
    }
    _titleLabel.text = shareModel[@"title"];
    
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 60, 60)];
        _imageView.backgroundColor = [UIColor redColor];
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 75, 60, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
