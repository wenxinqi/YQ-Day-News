//
//  YQCollectionViewWaterFlowLayout.h
//  DayNews
//
//  Created by 奇奇 on 2017/8/31.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQCollectionViewWaterFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, copy) CGFloat(^HeightBlock)(CGFloat width,NSIndexPath *indexPath);
//该属性是一个结构体，collectionView的内边距
@property (nonatomic , assign) UIEdgeInsets sectionInsets;
//每列之间的距离
@property (nonatomic, assign) CGFloat columnMargin;
//每行之间的距离
@property (nonatomic, assign) CGFloat rowMargin;
//行数
@property (nonatomic, assign) NSInteger columnsCount;
@end
