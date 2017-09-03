//
//  NSString+YQExtension.m
//  DayNews
//
//  Created by 奇奇 on 2017/8/29.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import "NSString+YQExtension.h"

@implementation NSString (YQExtension)
- (CGRect)stringWithMaxSize:(CGSize)maxSize andFont:(UIFont *)font
{
    NSDictionary *dic = [NSDictionary dictionary];
    [dic[NSFontAttributeName]  setFont:font];
    
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
}
@end
