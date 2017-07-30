//
//  YQTitleView.m
//  DayNews
//
//  Created by 奇奇 on 2017/7/24.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import "YQTitleView.h"

@implementation YQTitleView

+ (instancetype)titleVeiw
{
    return  [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil].lastObject;
}

@end
