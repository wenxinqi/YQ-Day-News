//
//  UIBarButtonItem+YQExtension.m
//  DayNews
//
//  Created by 奇奇 on 2017/8/29.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import "UIBarButtonItem+YQExtension.h"
#import "YQShowItemView.h"

@implementation UIBarButtonItem (YQExtension)
//添加一个类方法
+ (UIBarButtonItem *)itemWithImageAndTitle:(NSString *)title image:(NSString *)imageName target:(id)target Selector:(SEL)action
{
//    将传入的title和image设置，并给btn添加action
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
   
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];

//    添加点击事件
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
//    设置btn内部内容（左文字，右图片），并设置大小。默认情况下左图片，右文字
//    计算btn文字的宽度。
    CGRect titleRect = [title stringWithMaxSize:CGSizeMake(64, 44) andFont:[UIFont systemFontOfSize:11]];
    
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -50)];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
    
    btn.frame = CGRectMake(0, 0, titleRect.size.width + 20, 44);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    return item;
}
@end
