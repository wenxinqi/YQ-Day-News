//
//  NSDate+YQExtension.m
//  DayNews
//
//  Created by 奇奇 on 2017/8/26.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import "NSDate+YQExtension.h"

@implementation NSDate (YQExtension)
//时间转换
+ (NSString *)convertTime:(CGFloat)second{
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    //设置时间格式
    if (second/3600 >= 1) {
        [fmt setDateFormat:@"HH:mm:ss"];
    } else {
        [fmt setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [fmt stringFromDate:d];
    return showtimeNew;
}
@end
