//
//  YQHeaderView.m
//  DayNews
//
//  Created by 奇奇 on 2017/7/22.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import "YQHeaderView.h"

@implementation YQHeaderView
+ (instancetype)headerView
{
    return [[NSBundle mainBundle] loadNibNamed:@"YQHeaderView" owner:self options:nil].lastObject;
}
@end
