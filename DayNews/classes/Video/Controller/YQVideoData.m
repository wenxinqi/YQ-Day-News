//
//  YQVideoData.m
//  DayNews
//
//  Created by 奇奇 on 2017/8/6.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import "YQVideoData.h"

@implementation YQVideoData
//ptime = "2017-08-24 16:18:09"
-(NSString *)ptime
{
    NSString *str1 = [_ptime substringToIndex:10];
    str1 = [str1 substringFromIndex:5];
    
    return str1;
}
@end
