//
//  UIView+YQExtension.m
//  DayNews
//
//  Created by 奇奇 on 2017/7/26.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import "UIView+YQExtension.h"

@implementation UIView (YQExtension)

#warning 编译时不生成存取方法，运行时提供存取方法
@dynamic point;

//height
- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGFloat)height
{
    return self.frame.size.height;
}

//width
- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


- (CGFloat)width
{
    return self.frame.size.width;
}

//X
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

//Y
- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)y
{
    return self.frame.origin.y;
}
@end
