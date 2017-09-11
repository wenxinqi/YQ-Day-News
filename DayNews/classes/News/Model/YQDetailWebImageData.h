//
//  YQDetailWebImageData.h
//  DayNews
//
//  Created by 奇奇 on 2017/9/5.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YQDetailWebImageData : NSObject
@property (nonatomic, copy) NSString *src;
/** 图片尺寸 */
@property (nonatomic, copy) NSString *pixel;
/** 图片所处的位置 */
@property (nonatomic, copy) NSString *ref;

+ (instancetype)detailImgWithDict:(NSDictionary *)dict;
@end
