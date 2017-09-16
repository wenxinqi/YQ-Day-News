//
//  YQVideoHeaderView.m
//  DayNews
//
//  Created by 奇奇 on 2017/8/1.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import "YQVideoHeaderView.h"
#import "YQVerticalButton.h"

@implementation YQVideoHeaderView

//重写初始化方法，可以提供一些额外信息
- (instancetype)init
{
    if (self == [super init]) {
        
        self.frame = CGRectMake(0, 0, YQSCREEN_WIDTH, 100);
        
        CGFloat btnW = YQSCREEN_WIDTH * 0.25;
        NSArray *titleNames = @[@"奇葩",@"萌物",@"美女",@"精品"];
        NSArray *imageNames = @[@"qipa",@"mengwu",@"meinv",@"jingpin"];
        
        for (NSInteger i = 0; i <titleNames.count; i++) {
            
            CGFloat btnX = btnW * i;
            CGRect rect = CGRectMake(btnX, 0, btnW, 100);
            YQVerticalButton *btn = [[YQVerticalButton alloc] initWithFrame:rect];
            [btn setImage:[UIImage imageNamed:imageNames[i]] forState:UIControlStateNormal];
            [btn setTitle:titleNames[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = i;
            
            [self addSubview:btn];
        }
        
//        创建button之间的分隔线
        CGFloat separatorX = 0;
        for (NSInteger i = 0 ; i < 3 ; i++) {
            UIView *separatorV = [[UIView alloc] init];
            
            
            separatorX = (i + 1) * YQSCREEN_WIDTH * 0.25;
            separatorV.frame = CGRectMake(separatorX, 0, 1, 100);
            separatorV.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha: 1];
            
            [self addSubview:separatorV];
        }
    }
    return self;
}

//点击了按钮
- (void)btnClick:(UIButton *)btn
{
    if (self.selectBtn) {
        self.selectBtn(btn.tag, btn.titleLabel.text);
    }
}
- (void)awakeFromNib
{
    [super awakeFromNib];    
}



@end

