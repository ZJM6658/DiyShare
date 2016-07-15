//
//  Cell_ShareRow.m
//  UMengDiyShare
//
//  Created by zhujiamin on 16/7/13.
//  Copyright © 2016年 zhujiamin@yaomaitong.cn. All rights reserved.
//

#import "Cell_ShareRow.h"

@interface Cell_ShareRow()<UICollectionViewDelegate, UICollectionViewDataSource> {
    UICollectionView *_collectView;
    NSArray *_dataSource;
}
@end

@implementation Cell_ShareRow

- (void)layoutCellWithData:(NSArray *)dataArray {
    _dataSource = dataArray;
    if (!_collectView) {
        [self addSubview:self._collectView];
    }
}

- (UICollectionView *)_collectView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setItemSize:CGSizeMake(100, 100)];//设置cell的尺寸
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];//设置其布局方向
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);//设置其边界
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 5;
    _collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, [UIApplication sharedApplication].keyWindow.bounds.size.width, 100) collectionViewLayout:flowLayout];
    _collectView.delegate = self;
    _collectView.dataSource = self;
    [_collectView registerClass:[Cell_ShareItem class] forCellWithReuseIdentifier:@"zhujiamin"];
    _collectView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    _collectView.showsHorizontalScrollIndicator = NO;
    return _collectView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Cell_ShareItem *cell = (Cell_ShareItem *)[collectionView dequeueReusableCellWithReuseIdentifier:@"zhujiamin" forIndexPath:indexPath];
    [cell layoutUI:_dataSource[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = _dataSource[indexPath.row];
    NSString *actionStr = dic[@"actionName"];
    SEL action = NSSelectorFromString(actionStr);
     
    @try {
        if ([self.actionVC respondsToSelector:action]) {
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self.actionVC performSelector:action withObject:nil];
        }
    } @catch (NSException *exception) {
        
    }

}


@end
