//
//  YQVideoHeaderView.h
//  DayNews
//
//  Created by 奇奇 on 2017/8/1.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQVideoHeaderView : UIView
@property (nonatomic, copy) void(^selectBtn)(NSInteger tag, NSString *title);
@end
