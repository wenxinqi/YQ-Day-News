//
//  YQPicture.h
//  DayNews
//
//  Created by 奇奇 on 2017/8/31.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YQPictureData : NSObject
//创建图片内的所有模型属性
@property (nonatomic, assign) CGFloat small_width;
@property (nonatomic, assign) CGFloat small_height;
@property (nonatomic, copy) NSString *small_url;
@property (nonatomic, copy) NSString *title;

@property (nonatomic , copy) NSString *image_url;
@property (nonatomic , assign) CGFloat image_width;
@property (nonatomic , assign) CGFloat image_height;
@end
