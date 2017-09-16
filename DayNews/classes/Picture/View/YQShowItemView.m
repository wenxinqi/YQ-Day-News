//
//  YQShowItemView.m
//  DayNews
//
//  Created by 奇奇 on 2017/8/29.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import "YQShowItemView.h"

@implementation YQShowItemView
//重写初始化方法
- (instancetype)init
{
    if (self = [super init]) {
//        添加初始化信息
        self.frame = CGRectMake(0, 64, YQSCREEN_WIDTH, 300);
        
        [self setupItem];
        
        self.backgroundColor = YQRGBA(0, 0, 0, 0.8);
    }
    return self;
}

- (void)setupItem
{
//    向view里添加10个item
    NSArray *itemNames = @[@"美女",@"明星",@"汽车",@"宠物",@"动漫",@"设计",@"家居",@"婚嫁",@"摄影",@"美食"];
    NSArray *itemImages = @[@"meinvchannel",@"mingxing",@"qiche",@"chongwu",@"dongman",@"sheji",@"jiaju",@"hunjia",@"sheying",@"meishi"];
    
//    对item进行布局
    CGFloat width = (self.frame.size.width - 3*YQVideoCellMargin) * 0.25;
    CGFloat height = (self.frame.size.height - 2*YQVideoCellMargin) * 1/3;
   
    for (int i = 0 ; i < itemNames.count; i++) {
        int row = i/4;
        int col = i%4;
        CGRect rect = CGRectMake(col*(width+YQVideoCellMargin), row*(height+YQVideoCellMargin), width, height);
        YQVerticalButton *btn = [[YQVerticalButton alloc] initWithFrame:rect];
        
        [btn setTitle:itemNames[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:itemImages[i]] forState:UIControlStateNormal];
//        给按钮添加点击事件
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        
        [self addSubview:btn];
    }
}

//点击事件
- (void)btnClick:(UIButton *)btn
{
    if (self.selectBtn) {
        self.selectBtn(btn.titleLabel.text);
    }
}
- (void)addItemView
{
        [YQApplicationWindow addSubview:self];
        self.isShow = YES;
}

- (void)removeItemView
{
        [self removeFromSuperview];
        self.isShow = NO;
//        if (self.removeBlock) {
//            self.removeBlock();
//        }
    
}
@end
