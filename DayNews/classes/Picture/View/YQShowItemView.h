//
//  YQShowItemView.h
//  DayNews
//
//  Created by 奇奇 on 2017/8/29.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQShowItemView : UIView

//添加一个属性，判断该界面是否显示了
@property (nonatomic,assign,getter=isShow) BOOL isShow;
@property (nonatomic, copy) void(^selectBtn)(NSString *title);

- (void)addItemView;
- (void)removeItemView;
@end
