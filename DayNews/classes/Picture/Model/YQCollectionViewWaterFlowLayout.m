//
//  YQCollectionViewWaterFlowLayout.m
//  DayNews
//
//  Created by 奇奇 on 2017/8/31.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import "YQCollectionViewWaterFlowLayout.h"

@interface YQCollectionViewWaterFlowLayout()
@property (nonatomic , strong) NSMutableDictionary *maxYDict;
@property (nonatomic , strong) NSMutableArray *attrsArray;

@end

//自定义一个布局属性
@implementation YQCollectionViewWaterFlowLayout

- (instancetype)init
{
    if (self == [super init]) {
        self.columnMargin = 5;
        self.rowMargin = 5;
        self.sectionInset = UIEdgeInsetsMake(0, 5, 5, 5);
        self.columnsCount = 3;
    }
    return self;
}

/**
 * 当collectionView的显示范围发生改变的时候，是否需要重新刷新布局
 * 一旦重新刷新布局，就会重新调用下面的方法：
 1.prepareLayout
 2.layoutAttributesForElementsInRect:方法
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (void)prepareLayout
{
//    [super prepareLayout];
//    collectionview的滚动方向为垂直方向
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    // 1.清空最大的Y值
    for (int i = 0; i<self.columnsCount; i++) {
        NSString *column = [NSString stringWithFormat:@"%d", i];
        self.maxYDict[column] = @(self.sectionInset.top);
    }
    
    // 2.计算所有cell的属性
    [self.attrsArray removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i<count; i++) {
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attrsArray addObject:attrs];
    }
}

//设置在滚动范围内item的布局属性
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArray;
}

- (CGSize)collectionViewContentSize
{
//     假设第一列的y值最大
    __block NSString *maxColumn = @"0";
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL * _Nonnull stop) {
        if ([maxY floatValue] > [self.maxYDict[maxColumn] floatValue]) {
            maxColumn = column;
        }
    }];
    
    return CGSizeMake(0, [self.maxYDict[maxColumn] floatValue] + self.sectionInset.bottom);
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 假设最短的那一列的第0列
    __block NSString *minColumn = @"0";
    // 找出最短的那一列
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        if ([maxY floatValue] < [self.maxYDict[minColumn] floatValue]) {
            minColumn = column;
        }
    }];
//    设置item的属性
    
    CGFloat width = (YQSCREEN_WIDTH - (self.columnsCount-1)*self.columnMargin - 2 * self.sectionInset.right) / self.columnsCount;
//    截获当前item的宽，和当前的序列号。
    CGFloat height = self.HeightBlock(width,indexPath);
    CGFloat x = self.sectionInset.left + (width + self.columnMargin) * [minColumn intValue];
    CGFloat y = [self.maxYDict[minColumn] intValue] + self.rowMargin;
    
//    更新这一列的最大Y值
    self.maxYDict[minColumn] = @(y + height);
    
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    attrs.frame = CGRectMake(x, y, width, height);
    
    return attrs;
}

#pragma mark lazy
- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        self.attrsArray = [[NSMutableArray alloc] init];
    }
    return _attrsArray;
}

- (NSMutableDictionary *)maxYDict
{
    if (!_maxYDict) {
        self.maxYDict = [[NSMutableDictionary alloc] init];
    }
    return _maxYDict;
}
@end
