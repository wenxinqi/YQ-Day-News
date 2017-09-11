//
//  YQDetailWebImageData.m
//  DayNews
//
//  Created by 奇奇 on 2017/9/5.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import "YQDetailWebImageData.h"

@implementation YQDetailWebImageData
+ (instancetype)detailImgWithDict:(NSDictionary *)dict
{
    YQDetailWebImageData *imgModel = [[self alloc]init];
    imgModel.ref = dict[@"ref"];
    imgModel.pixel = dict[@"pixel"];
    imgModel.src = dict[@"src"];
    
    return imgModel;
}
@end
