//
//  UIBarButtonItem+YQExtension.h
//  DayNews
//
//  Created by 奇奇 on 2017/8/29.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (YQExtension)
+ (UIBarButtonItem *)ItemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action;
+ (UIBarButtonItem *)itemWithImageAndTitle:(NSString *)title image:(NSString *)imageName target:(id)target Selector:(SEL)action;
@end
