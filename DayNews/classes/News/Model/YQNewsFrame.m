//
//  YQNewsFrame.m
//  DayNews
//
//  Created by 奇奇 on 2017/9/5.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import "YQNewsFrame.h"

#import "YQNewsData.h"

@implementation YQNewsFrame

-(void)setNewData:(YQNewsData *)NewsData
{
    _NewsData = NewsData;
    
    //图片
    CGFloat picurlX = 5;
    CGFloat picurlY = 10;
    CGFloat picurlW = 100;
    CGFloat picurlH = 70;
    _picUrlF = CGRectMake(picurlX, picurlY, picurlW, picurlH);
    
    //title
    CGFloat titleX = CGRectGetMaxX(_picUrlF) + 10;
    CGFloat titleY = picurlY;
    CGFloat titleW = YQSCREEN_WIDTH - 5 - titleX;
    CGFloat titleH = 45;
    _titleF = CGRectMake(titleX, titleY, titleW, titleH);
    
    
    _cellH = CGRectGetMaxY(_picUrlF) + 10;
    
}
@end
