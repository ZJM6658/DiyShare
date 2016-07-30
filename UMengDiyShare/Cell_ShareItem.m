//
//  ImageCollectionViewCell.m
//  GetTheWholeImage
//
//  Created by zhujiamin on 16/5/25.
//  Copyright © 2016年 zhujiamin@yaomaitong.cn. All rights reserved.
//

#import "Cell_ShareItem.h"
//#import "M_Share.h"

@implementation Cell_ShareItem

#pragma mark - outside methods
- (void)layoutUI:(id )shareModel {
    if (!_imageView) {
        [self.contentView addSubview:self.imageView];
    }
    if (!_titleLabel) {
        [self.contentView addSubview:self.titleLabel];
    }
    
    NSDictionary *model = (NSDictionary *)shareModel;
    _imageView.image = [UIImage imageNamed:model[@"imageName"]];
    _titleLabel.text = model[@"title"];
    
    //使用模型的布局方式
//    M_Share *model = (M_Share *)shareModel;
//    _imageView.image = [UIImage imageNamed:model.imageName];
//    _titleLabel.text = model.title;

}

#pragma mark - getter & setter
- (UIImageView *)imageView {
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 60, 60)];
    _imageView.backgroundColor = [UIColor whiteColor];
    return _imageView;
}

- (UILabel *)titleLabel {
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 75, 60, 20)];
    _titleLabel.font = [UIFont systemFontOfSize:12];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    return _titleLabel;
}

@end
