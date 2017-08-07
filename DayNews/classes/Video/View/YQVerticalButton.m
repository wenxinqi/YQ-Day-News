//
//  YQVerticalButton.m
//  DayNews
//
//  Created by 奇奇 on 2017/8/1.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import "YQVerticalButton.h"

#define YQButtonRatio  0.6
@implementation YQVerticalButton


/**
 需求：图片在上面 ，textlabel在下面， 图片被切割成圆形
 */

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:18];
        
    }
    return self;
}


//对内部子控件进行布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect imageVRect = self.imageView.frame;
    
    self.imageView.contentMode = UIViewContentModeCenter;
    imageVRect.origin.x = 0;
    imageVRect.origin.y = 0;
    imageVRect.size.width = self.width;
    imageVRect.size.height = self.height * YQButtonRatio;
    
    self.imageView.frame = imageVRect;
    
    CGRect titleLabelRect = self.titleLabel.frame;
    
    titleLabelRect.origin.x = 0;
    titleLabelRect.origin.y = self.height * YQButtonRatio;
    titleLabelRect.size.width = self.width;
    titleLabelRect.size.height = self.height - self.height * YQButtonRatio;
    
    self.titleLabel.frame = titleLabelRect;
    
    
}

@end
